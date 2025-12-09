import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/api_end_points.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/translator_service.dart';
import '../../../data/model/product/product_details_response.dart';
import '../../../view_model/language/language_provider.dart';

class GetProductDetailsProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final AppTranslator _translator = AppTranslator();

  bool _loading = false;
  bool _isTranslating = false;
  String? _message;

  // Translation progress
  int _translationProgress = 0;
  int _totalToTranslate = 0;

  // Language management
  late String _currentLanguage;

  // Stream subscription for language changes
  StreamSubscription<String>? _languageChangeSubscription;

  // Translation cache (shared across all providers for efficiency)
  static final Map<String, Map<String, String>> _sharedTranslationCache = {};

  ProductDetailsResponse? _productDetailsResponse;

  // Getters
  bool get loading => _loading;
  bool get isTranslating => _isTranslating;
  String? get message => _message;
  ProductDetailsResponse? get productDetailsResponse => _productDetailsResponse;
  int get translationProgress => _translationProgress;
  int get totalToTranslate => _totalToTranslate;
  String get currentLanguage => _currentLanguage;

  GetProductDetailsProvider() {
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

    // Re-translate existing product details if any
    if (_productDetailsResponse?.data != null) {
      await _translateProductDetails();
    } else {
      notifyListeners();
    }
  }

  Future<void> _translateProductDetails() async {
    if (_productDetailsResponse?.data == null) return;

    _isTranslating = true;
    _translationProgress = 0;
    _totalToTranslate = 5; // title, description, condition, size, color, location
    notifyListeners();

    // Initialize shared cache for current language if not exists
    if (!_sharedTranslationCache.containsKey(_currentLanguage)) {
      _sharedTranslationCache[_currentLanguage] = {};
    }

    final cache = _sharedTranslationCache[_currentLanguage]!;
    final product = _productDetailsResponse!.data!;

    // Translate title
    final titleKey = 'title_${product.productId}';
    if (!cache.containsKey(titleKey)) {
      product.translatedTitle = await _translator.translateText(product.title ?? '');
      cache[titleKey] = product.translatedTitle ?? product.title ?? '';
      _translationProgress++;
      notifyListeners();
    } else {
      product.translatedTitle = cache[titleKey];
    }

    // Translate description
    final descriptionKey = 'desc_${product.productId}';
    if (!cache.containsKey(descriptionKey) && product.description != null) {
      product.translatedDescription = await _translator.translateText(product.description!);
      cache[descriptionKey] = product.translatedDescription ?? product.description ?? '';
      _translationProgress++;
      notifyListeners();
    } else if (product.description != null) {
      product.translatedDescription = cache[descriptionKey];
    }

    // Translate condition
    final conditionKey = 'condition_${product.condition}_${product.productId}';
    if (!cache.containsKey(conditionKey) && product.condition != null) {
      product.translatedCondition = await _translator.translateText(product.condition!);
      cache[conditionKey] = product.translatedCondition ?? product.condition ?? '';
      _translationProgress++;
      notifyListeners();
    } else if (product.condition != null) {
      product.translatedCondition = cache[conditionKey];
    }

    // Translate size
    final sizeKey = 'size_${product.size}_${product.productId}';
    if (!cache.containsKey(sizeKey) && product.size != null) {
      product.translatedSize = await _translator.translateText(product.size!);
      cache[sizeKey] = product.translatedSize ?? product.size ?? '';
      _translationProgress++;
      notifyListeners();
    } else if (product.size != null) {
      product.translatedSize = cache[sizeKey];
    }

    // Translate color
    final colorKey = 'color_${product.color}_${product.productId}';
    if (!cache.containsKey(colorKey) && product.color != null) {
      product.translatedColor = await _translator.translateText(product.color!);
      cache[colorKey] = product.translatedColor ?? product.color ?? '';
      _translationProgress++;
      notifyListeners();
    } else if (product.color != null) {
      product.translatedColor = cache[colorKey];
    }

    // Translate location
    final locationKey = 'location_${product.location}_${product.productId}';
    if (!cache.containsKey(locationKey) && product.location != null) {
      product.translatedLocation = await _translator.translateText(product.location!);
      cache[locationKey] = product.translatedLocation ?? product.location ?? '';
      _translationProgress++;
      notifyListeners();
    } else if (product.location != null) {
      product.translatedLocation = cache[locationKey];
    }

    // Translate category name if exists
    if (product.category?.categoryName != null) {
      final categoryKey = 'category_${product.category!.id}';
      if (!cache.containsKey(categoryKey)) {
        product.category!.translatedName = await _translator.translateText(product.category!.categoryName!);
        cache[categoryKey] = product.category!.translatedName ?? product.category!.categoryName!;
        _translationProgress++;
        notifyListeners();
      } else {
        product.category!.translatedName = cache[categoryKey];
      }
    }

    _isTranslating = false;
    _translationProgress = 0;
    _totalToTranslate = 0;
    notifyListeners();
  }

  Future<void> getProductDetails(String id) async {
    _setLoading(true);

    try {
      final response = await _apiService.get(ApiEndpoints.getProductDetailsById(id));

      if (response.statusCode == 200 || response.statusCode == 201) {
        _productDetailsResponse = ProductDetailsResponse.fromJson(response.data);
        _message = response.data['message'];

        // Translate product details if language is not English
        if (_productDetailsResponse?.data != null && _currentLanguage != 'en') {
          await _translateProductDetails();
        }

        _setLoading(false);
        notifyListeners();
      } else {
        _setLoading(false);
        _message = response.data['message'];
        notifyListeners();
      }
    } catch (e) {
      _setLoading(false);
      _message = "Something went wrong: $e";
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // Force refresh translations
  Future<void> refreshTranslations() async {
    if (_productDetailsResponse?.data != null && _currentLanguage != 'en') {
      await _translateProductDetails();
    }
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // Clear all data
  void clear() {
    _productDetailsResponse = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _languageChangeSubscription?.cancel();
    _translator.dispose();
    super.dispose();
  }
}