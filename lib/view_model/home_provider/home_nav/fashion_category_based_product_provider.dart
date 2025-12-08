import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/constants/api_end_points.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/translator_service.dart';
import '../../../data/model/home/category_based_product_model.dart';
import '../../../view_model/language/language_provider.dart';

class FashionCategoryBasedProductProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isTranslating = false;
  String _errorMessage = '';

  // Translation progress
  int _translationProgress = 0;
  int _totalToTranslate = 0;

  // Language management
  String _currentLanguage = 'en';

  CategoryBasedProductModel? _categoryBasedProductModel;
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
  CategoryBasedProductModel? get categoryBasedProductModel => _categoryBasedProductModel;
  int get translationProgress => _translationProgress;
  int get totalToTranslate => _totalToTranslate;
  String get currentLanguage => _currentLanguage;

  FashionCategoryBasedProductProvider() {
    _initializeTranslator();
  }

  void _initializeTranslator() async {
    // Initialize with default language
    await _translator.setLanguage(_currentLanguage);

    // Listen to language change events
    _listenToLanguageChanges();
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

    await _translator.setLanguage(newLang);

    _translationCache.clear();
    if (_categoryBasedProductModel != null && _categoryBasedProductModel!.data.isNotEmpty) {
      _isTranslating = true;
      _translationProgress = 0;
      _totalToTranslate = _categoryBasedProductModel!.data.length * 3; // title, size, condition
      notifyListeners();

      await _translateAllProducts(_categoryBasedProductModel!.data);

      _isTranslating = false;
      _translationProgress = 0;
      _totalToTranslate = 0;
      notifyListeners();
    } else {
      notifyListeners();
    }
  }

  Future<void> changeLanguage(String langCode) async {
    await _handleLanguageChange(langCode);
  }

  Future<void> _translateAllProducts(List<ProductData> products) async {
    if (products.isEmpty) return;

    // Initialize cache for current language
    if (!_translationCache.containsKey(_currentLanguage)) {
      _translationCache[_currentLanguage] = {};
    }

    final cache = _translationCache[_currentLanguage]!;

    for (int i = 0; i < products.length; i++) {
      final product = products[i];

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

      // Translate size if exists
      if (product.size != null && product.size!.isNotEmpty) {
        final sizeKey = 'size_${product.size}';
        if (!cache.containsKey(sizeKey)) {
          product.translatedSize = await _translator.translateText(product.size!);
          cache[sizeKey] = product.translatedSize!;
          _translationProgress++;
          notifyListeners();
        } else {
          product.translatedSize = cache[sizeKey];
        }
      }

      // Translate condition
      final conditionKey = 'condition_${product.condition}';
      if (!cache.containsKey(conditionKey)) {
        product.translatedCondition = await _translator.translateText(product.condition);
        cache[conditionKey] = product.translatedCondition!;
        _translationProgress++;
        notifyListeners();
      } else {
        product.translatedCondition = cache[conditionKey];
      }
    }
  }

  Future<bool> getCategoryBasedProduct(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.get(
        ApiEndpoints.getProductsByCategory(id, 1, 10),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _categoryBasedProductModel = CategoryBasedProductModel.fromJson(response.data);
        _errorMessage = response.data['message'] ?? '';

        // Translate products if model exists
        if (_categoryBasedProductModel!.data.isNotEmpty) {
          _isTranslating = true;
          _translationProgress = 0;
          _totalToTranslate = _categoryBasedProductModel!.data.length * 3;
          notifyListeners();

          await _translateAllProducts(_categoryBasedProductModel!.data);

          _isTranslating = false;
          _translationProgress = 0;
          _totalToTranslate = 0;
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

  // Load more products with pagination
  Future<bool> loadMoreProducts(String id) async {
    if (_categoryBasedProductModel == null ||
        !_categoryBasedProductModel!.pagination.hasNextPage) {
      return false;
    }

    final nextPage = _categoryBasedProductModel!.pagination.page + 1;

    try {
      final response = await _apiService.get(
        ApiEndpoints.getProductsByCategory(id, nextPage, 10),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newData = CategoryBasedProductModel.fromJson(response.data);

        // Translate new products
        if (newData.data.isNotEmpty) {
          final currentProgress = _translationProgress;
          _totalToTranslate += newData.data.length * 3;
          await _translateAllProducts(newData.data);
        }

        // Merge new data with existing
        _categoryBasedProductModel = CategoryBasedProductModel(
          success: newData.success,
          message: newData.message,
          data: [..._categoryBasedProductModel!.data, ...newData.data],
          pagination: newData.pagination,
        );

        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error loading more products: $e");
      return false;
    }
  }

  // Clear all data
  void clear() {
    _categoryBasedProductModel = null;
    _translationCache.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _languageChangeSubscription?.cancel();
    _translator.dispose();
    super.dispose();
  }
}