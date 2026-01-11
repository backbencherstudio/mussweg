// lib/view_model/profile/user_all_products/user_all_products_provider.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/api_end_points.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/translator_service.dart';
import '../../../data/user_all_products/user_all_products_viewmodel.dart';
import '../../../view_model/language/language_provider.dart';

class UserAllProductsProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isTranslating = false;
  String _errorMessage = '';

  // Translation progress
  int _translationProgress = 0;
  int _totalToTranslate = 0;

  // Language management
  String _currentLanguage = 'en';

  UserAllProductsViewmodel? _userAllProductsViewmodel;
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
  UserAllProductsViewmodel? get userAllProductsViewmodel => _userAllProductsViewmodel;
  int get translationProgress => _translationProgress;
  int get totalToTranslate => _totalToTranslate;
  String get currentLanguage => _currentLanguage;

  UserAllProductsProvider() {
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

    // Re-translate existing products if any
    if (_userAllProductsViewmodel != null && _userAllProductsViewmodel!.data.isNotEmpty) {
      await _translateExistingProducts();
    } else {
      notifyListeners();
    }
  }

  Future<void> _translateExistingProducts() async {
    if (_userAllProductsViewmodel == null || _userAllProductsViewmodel!.data.isEmpty) return;

    _isTranslating = true;
    _translationProgress = 0;
    // Calculate total items to translate: title, description, location, condition, size, color (6 fields)
    _totalToTranslate = _userAllProductsViewmodel!.data.length * 6;
    notifyListeners();

    // Initialize cache for current language if not exists
    if (!_translationCache.containsKey(_currentLanguage)) {
      _translationCache[_currentLanguage] = {};
    }

    final cache = _translationCache[_currentLanguage]!;

    for (int i = 0; i < _userAllProductsViewmodel!.data.length; i++) {
      final product = _userAllProductsViewmodel!.data[i];

      // Translate title
      final titleKey = 'title_${product.id}';
      if (!cache.containsKey(titleKey)) {
        product.translatedTitle = await _translator.translateText(product.title);
        cache[titleKey] = product.translatedTitle!;
        _translationProgress++;
        notifyListeners();
      } else {
        product.translatedTitle = cache[titleKey];
      }

      // Translate description
      final descriptionKey = 'description_${product.id}';
      if (!cache.containsKey(descriptionKey)) {
        product.translatedDescription = await _translator.translateText(product.description);
        cache[descriptionKey] = product.translatedDescription!;
        _translationProgress++;
        notifyListeners();
      } else {
        product.translatedDescription = cache[descriptionKey];
      }

      // Translate location
      final locationKey = 'location_${product.location}_${product.id}';
      if (!cache.containsKey(locationKey)) {
        product.translatedLocation = await _translator.translateText(product.location);
        cache[locationKey] = product.translatedLocation!;
        _translationProgress++;
        notifyListeners();
      } else {
        product.translatedLocation = cache[locationKey];
      }

      // Translate condition
      final conditionKey = 'condition_${product.condition}_${product.id}';
      if (!cache.containsKey(conditionKey)) {
        product.translatedCondition = await _translator.translateText(product.condition);
        cache[conditionKey] = product.translatedCondition!;
        _translationProgress++;
        notifyListeners();
      } else {
        product.translatedCondition = cache[conditionKey];
      }

      // Translate size
      final sizeKey = 'size_${product.size}_${product.id}';
      if (!cache.containsKey(sizeKey)) {
        product.translatedSize = await _translator.translateText(product.size);
        cache[sizeKey] = product.translatedSize!;
        _translationProgress++;
        notifyListeners();
      } else {
        product.translatedSize = cache[sizeKey];
      }

      // Translate color
      final colorKey = 'color_${product.color}_${product.id}';
      if (!cache.containsKey(colorKey)) {
        product.translatedColor = await _translator.translateText(product.color);
        cache[colorKey] = product.translatedColor!;
        _translationProgress++;
        notifyListeners();
      } else {
        product.translatedColor = cache[colorKey];
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

  Future<bool> getAllUserProduct() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiEndpoints.userAllProducts);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _userAllProductsViewmodel = UserAllProductsViewmodel.fromJson(response.data);

        // Translate products if model exists and language is not English
        if (_userAllProductsViewmodel!.data.isNotEmpty && _currentLanguage != 'en') {
          await _translateExistingProducts();
        }

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        _errorMessage = response.data['message'] ?? 'Something went wrong';
        notifyListeners();
        return false;
      }
    } catch (e) {
      debugPrint("Error fetching user all products: $e");
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Load more products with pagination
  Future<bool> loadMoreUserProducts() async {
    if (_userAllProductsViewmodel == null ||
        !_userAllProductsViewmodel!.pagination.hasNextPage) {
      return false;
    }

    final nextPage = _userAllProductsViewmodel!.pagination.page + 1;

    try {
      final response = await _apiService.get(
        '${ApiEndpoints.userAllProducts}?page=$nextPage&limit=10',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newData = UserAllProductsViewmodel.fromJson(response.data);

        // Initialize cache for current language if not exists
        if (!_translationCache.containsKey(_currentLanguage)) {
          _translationCache[_currentLanguage] = {};
        }

        final cache = _translationCache[_currentLanguage]!;

        // Translate new products if language is not English
        if (newData.data.isNotEmpty && _currentLanguage != 'en') {
          _isTranslating = true;
          _translationProgress = 0;
          _totalToTranslate = newData.data.length * 6; // 6 fields per product
          notifyListeners();

          for (final product in newData.data) {
            // Translate title
            final titleKey = 'title_${product.id}';
            if (!cache.containsKey(titleKey)) {
              product.translatedTitle = await _translator.translateText(product.title);
              cache[titleKey] = product.translatedTitle!;
              _translationProgress++;
              notifyListeners();
            } else {
              product.translatedTitle = cache[titleKey];
            }

            // Translate description
            final descriptionKey = 'description_${product.id}';
            if (!cache.containsKey(descriptionKey)) {
              product.translatedDescription = await _translator.translateText(product.description);
              cache[descriptionKey] = product.translatedDescription!;
              _translationProgress++;
              notifyListeners();
            } else {
              product.translatedDescription = cache[descriptionKey];
            }

            // Translate location
            final locationKey = 'location_${product.location}_${product.id}';
            if (!cache.containsKey(locationKey)) {
              product.translatedLocation = await _translator.translateText(product.location);
              cache[locationKey] = product.translatedLocation!;
              _translationProgress++;
              notifyListeners();
            } else {
              product.translatedLocation = cache[locationKey];
            }

            // Translate condition
            final conditionKey = 'condition_${product.condition}_${product.id}';
            if (!cache.containsKey(conditionKey)) {
              product.translatedCondition = await _translator.translateText(product.condition);
              cache[conditionKey] = product.translatedCondition!;
              _translationProgress++;
              notifyListeners();
            } else {
              product.translatedCondition = cache[conditionKey];
            }

            // Translate size
            final sizeKey = 'size_${product.size}_${product.id}';
            if (!cache.containsKey(sizeKey)) {
              product.translatedSize = await _translator.translateText(product.size);
              cache[sizeKey] = product.translatedSize!;
              _translationProgress++;
              notifyListeners();
            } else {
              product.translatedSize = cache[sizeKey];
            }

            // Translate color
            final colorKey = 'color_${product.color}_${product.id}';
            if (!cache.containsKey(colorKey)) {
              product.translatedColor = await _translator.translateText(product.color);
              cache[colorKey] = product.translatedColor!;
              _translationProgress++;
              notifyListeners();
            } else {
              product.translatedColor = cache[colorKey];
            }
          }

          _isTranslating = false;
          _translationProgress = 0;
          _totalToTranslate = 0;
        }

        // Merge new data with existing
        _userAllProductsViewmodel = UserAllProductsViewmodel(
          data: [
            ..._userAllProductsViewmodel!.data,
            ...newData.data,
          ],
          pagination: newData.pagination,
        );


        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error loading more user products: $e");
      return false;
    }
  }

  // Helper methods to get translated text for display
  String getTranslatedTitle(ProductData product) {
    return product.translatedTitle ?? product.title;
  }

  String getTranslatedCondition(ProductData product) {
    return product.translatedCondition ?? product.condition;
  }

  String getTranslatedSize(ProductData product) {
    return product.translatedSize ?? product.size;
  }

  String getTranslatedDescription(ProductData product) {
    return product.translatedDescription ?? product.description;
  }

  String getTranslatedLocation(ProductData product) {
    return product.translatedLocation ?? product.location;
  }

  String getTranslatedColor(ProductData product) {
    return product.translatedColor ?? product.color;
  }

  // Clear all data
  void clear() {
    _userAllProductsViewmodel = null;
    // Don't clear translation cache - keep it for better performance
    notifyListeners();
  }

  // Helper method to refresh data
  Future<bool> refreshData() async {
    return await getAllUserProduct();
  }

  // Force refresh translations (useful when coming back from background)
  Future<void> refreshTranslations() async {
    if (_userAllProductsViewmodel != null &&
        _userAllProductsViewmodel!.data.isNotEmpty &&
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