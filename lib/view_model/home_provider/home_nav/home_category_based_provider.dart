import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/api_end_points.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/translator_service.dart';
import '../../../data/model/home/category_based_product_model.dart';
import '../../../view_model/language/language_provider.dart';

class HomeCategoryBasedProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isTranslating = false;
  String _errorMessage = '';

  // Translation progress
  int _translationProgress = 0;
  int _totalToTranslate = 0;

  // Language management
  late String _currentLanguage;

  CategoryBasedProductModel? _categoryBasedProductModel;
  CategoryBasedProductModel? get categoryBasedProductModel =>
      _categoryBasedProductModel;

  final ApiService _apiService = ApiService();
  final AppTranslator _translator = AppTranslator();

  // Stream subscription for language changes
  StreamSubscription<String>? _languageChangeSubscription;

  // Translation cache
  final Map<String, Map<String, String>> _translationCache = {};

  // Getters
  bool get isLoading => _isLoading;
  bool get isTranslating => _isTranslating;
  String get errorMessage => _errorMessage;
  int get translationProgress => _translationProgress;
  int get totalToTranslate => _totalToTranslate;
  String get currentLanguage => _currentLanguage;

  HomeCategoryBasedProvider() {
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
    _languageChangeSubscription = LanguageProvider.languageChangeEvents.listen((
      newLang,
    ) async {
      if (newLang != _currentLanguage) {
        await _handleLanguageChange(newLang);
      }
    });
  }

  Future<void> _handleLanguageChange(String newLang) async {
    if (newLang == _currentLanguage) return;

    _currentLanguage = newLang;

    // Save the language change
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', newLang);

    await _translator.setLanguage(newLang);

    // Re-translate existing products if any
    if (_categoryBasedProductModel != null &&
        _categoryBasedProductModel!.data.isNotEmpty) {
      await _translateExistingProducts();
    } else {
      notifyListeners();
    }
  }

  Future<void> _translateExistingProducts() async {
    if (_categoryBasedProductModel == null ||
        _categoryBasedProductModel!.data.isEmpty)
      return;

    _isTranslating = true;
    _translationProgress = 0;
    _totalToTranslate =
        _categoryBasedProductModel!.data.length * 3; // title, size, condition
    notifyListeners();

    // Initialize cache for current language if not exists
    if (!_translationCache.containsKey(_currentLanguage)) {
      _translationCache[_currentLanguage] = {};
    }

    final cache = _translationCache[_currentLanguage]!;

    for (int i = 0; i < _categoryBasedProductModel!.data.length; i++) {
      final product = _categoryBasedProductModel!.data[i];

      // Translate title
      final titleKey = 'title_${product.id}';
      if (!cache.containsKey(titleKey)) {
        product.translatedTitle = await _translator.translateText(
          product.title,
        );
        cache[titleKey] = product.translatedTitle!;
        _translationProgress++;
        notifyListeners();
      } else {
        product.translatedTitle = cache[titleKey];
      }

      // Translate size if exists
      if (product.size != null && product.size!.isNotEmpty) {
        final sizeKey = 'size_${product.size}_${product.id}';
        if (!cache.containsKey(sizeKey)) {
          product.translatedSize = await _translator.translateText(
            product.size!,
          );
          cache[sizeKey] = product.translatedSize!;
          _translationProgress++;
          notifyListeners();
        } else {
          product.translatedSize = cache[sizeKey];
        }
      }

      // Translate condition
      final conditionKey = 'condition_${product.condition}_${product.id}';
      if (!cache.containsKey(conditionKey)) {
        product.translatedCondition = await _translator.translateText(
          product.condition,
        );
        cache[conditionKey] = product.translatedCondition!;
        _translationProgress++;
        notifyListeners();
      } else {
        product.translatedCondition = cache[conditionKey];
      }
    }

    _isTranslating = false;
    _translationProgress = 0;
    _totalToTranslate = 0;
    notifyListeners();
  }

  Future<bool> getCategoryBasedProduct(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.get(
        ApiEndpoints.getProductsByCategory(id, 1, 10),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _categoryBasedProductModel = CategoryBasedProductModel.fromJson(
          response.data,
        );
        _errorMessage = response.data['message'] ?? '';

        // Translate products if model exists and language is not English
        if (_categoryBasedProductModel!.data.isNotEmpty &&
            _currentLanguage != 'en') {
          await _translateExistingProducts();
        }

        _isLoading = false;
        notifyListeners();
        return response.data['success'] ?? false;
      } else {
        _isLoading = false;
        _errorMessage = response.data['message'] ?? 'Something went wrong';
        notifyListeners();
        return false;
      }
    } catch (e) {
      debugPrint("Error for fetching category based product: $e");
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Clear all data
  void clear() {
    _categoryBasedProductModel = null;
    notifyListeners();
  }

  // Force refresh translations
  Future<void> refreshTranslations() async {
    if (_categoryBasedProductModel != null &&
        _categoryBasedProductModel!.data.isNotEmpty &&
        _currentLanguage != 'en') {
      await _translateExistingProducts();
    }
  }

  @override
  void dispose() {
    _languageChangeSubscription?.cancel();
    _translator.dispose();
    super.dispose();
  }
}
