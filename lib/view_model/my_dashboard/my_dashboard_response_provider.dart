// lib/view_model/my_dashboard/my_dashboard_response_provider.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/api_end_points.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/translator_service.dart';
import '../../../data/model/user/my_dashboard_response_model.dart';
import '../../../view_model/language/language_provider.dart';

class MyDashboardResponseProvider extends ChangeNotifier {
  bool _loading = false;
  bool _isTranslating = false;
  String? _error;

  // Translation progress
  int _translationProgress = 0;
  int _totalToTranslate = 0;

  // Language management
  String _currentLanguage = 'en';

  MyDashboardResponseModel? _myDashboardResponseModel;
  final ApiService _apiService = ApiService();
  final AppTranslator _translator = AppTranslator();

  // Stream subscription for language changes
  StreamSubscription<String>? _languageChangeSubscription;

  // Translation cache
  final Map<String, Map<String, String>> _translationCache = {};

  // Getters
  bool get loading => _loading;
  bool get isTranslating => _isTranslating;
  String? get error => _error;
  MyDashboardResponseModel? get myDashboardResponseModel => _myDashboardResponseModel;
  int get translationProgress => _translationProgress;
  int get totalToTranslate => _totalToTranslate;
  String get currentLanguage => _currentLanguage;

  MyDashboardResponseProvider() {
    _initializeProvider();
  }

  Future<void> _initializeProvider() async {
    // Load saved language on initialization
    await _loadSavedLanguage();

    // Initialize translator with saved language
    await _translator.setLanguage(_currentLanguage);

    // Listen to language change events
    _listenToLanguageChanges();
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString('selected_language') ?? 'en';
  }

  void _listenToLanguageChanges() {
    _languageChangeSubscription = LanguageProvider.languageChangeEvents.listen(
          (newLang) async {
        if (newLang != _currentLanguage) {
          await _handleLanguageChange(newLang);
        }
      },
    );
  }

  Future<void> _handleLanguageChange(String newLang) async {
    if (newLang == _currentLanguage) return;

    _currentLanguage = newLang;

    // Save the language change
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', newLang);

    await _translator.setLanguage(newLang);

    // Clear translation cache for old language if needed
    if (_translationCache.containsKey(_currentLanguage)) {
      // We can keep the cache for current language
    }

    // Re-translate existing data if any
    if (_myDashboardResponseModel != null) {
      await _translateExistingData();
    } else {
      notifyListeners();
    }
  }

  Future<void> _translateExistingData() async {
    if (_myDashboardResponseModel == null) return;

    _isTranslating = true;
    _translationProgress = 0;

    // Calculate total items to translate: reviews + products
    final reviewCount = _myDashboardResponseModel!.data.reviews.data.length;
    final productCount = _myDashboardResponseModel!.data.products.data.length;
    _totalToTranslate = reviewCount + productCount; // 1 field each (comment/title)

    notifyListeners();

    // Initialize cache for current language if not exists
    if (!_translationCache.containsKey(_currentLanguage)) {
      _translationCache[_currentLanguage] = {};
    }

    final cache = _translationCache[_currentLanguage]!;

    // Translate reviews
    for (int i = 0; i < _myDashboardResponseModel!.data.reviews.data.length; i++) {
      final review = _myDashboardResponseModel!.data.reviews.data[i];

      // Translate comment
      final commentKey = 'review_comment_${review.id}';
      if (!cache.containsKey(commentKey)) {
        review.translatedComment = await _translator.translateText(review.comment);
        cache[commentKey] = review.translatedComment!;
        _translationProgress++;
        notifyListeners();
      } else {
        review.translatedComment = cache[commentKey];
      }
    }

    // Translate product titles
    for (int i = 0; i < _myDashboardResponseModel!.data.products.data.length; i++) {
      final product = _myDashboardResponseModel!.data.products.data[i];

      // Translate title
      final titleKey = 'product_title_${product.id}';
      if (!cache.containsKey(titleKey)) {
        product.translatedTitle = await _translator.translateText(product.productTitle);
        cache[titleKey] = product.translatedTitle!;
        _translationProgress++;
        notifyListeners();
      } else {
        product.translatedTitle = cache[titleKey];
      }
    }

    _isTranslating = false;
    _translationProgress = 0;
    _totalToTranslate = 0;
    notifyListeners();
  }

  Future<void> changeLanguage(String langCode) async {
    await _handleLanguageChange(langCode);
  }

  Future<void> fetchMyDashboardData() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiEndpoints.getMyDashboardDetails);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _myDashboardResponseModel = MyDashboardResponseModel.fromJson(response.data);

        // Translate data if model exists and language is not English
        if (_currentLanguage != 'en' && _myDashboardResponseModel != null) {
          await _translateExistingData();
        }

        _loading = false;
        notifyListeners();
      } else {
        _error = response.data['message'] ?? "Server error";
        _myDashboardResponseModel = null;
        _loading = false;
        notifyListeners();
      }
    } catch (e, stack) {
      debugPrint("Dashboard fetch error: $e\n$stack");
      _error = "Failed to load dashboard";
      _myDashboardResponseModel = null;
      _loading = false;
      notifyListeners();
    }
  }

  // Helper methods to get translated text for display
  String getTranslatedReviewComment(ReviewData review) {
    return review.translatedComment ?? review.comment;
  }

  String getTranslatedProductTitle(ProductData product) {
    return product.translatedTitle ?? product.productTitle;
  }

  // Clear all data
  void clear() {
    _myDashboardResponseModel = null;
    // Don't clear translation cache - keep it for better performance
    notifyListeners();
  }

  // Force refresh translations (useful when coming back from background)
  Future<void> refreshTranslations() async {
    if (_myDashboardResponseModel != null && _currentLanguage != 'en') {
      await _translateExistingData();
    }
  }

  @override
  void dispose() {
    _languageChangeSubscription?.cancel();
    _translator.dispose();
    super.dispose();
  }
}