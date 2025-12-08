// lib/view_model/whistlist/whistlist_provider_of_get_favourite_product.dart
import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/services/api_service.dart';
import '../../core/services/translator_service.dart';
import '../../data/model/whistlist/favourite_product_model.dart';
import '../../core/constants/api_end_points.dart';
import '../../view_model/language/language_provider.dart';

class WhistlistProviderOfGetFavouriteProduct extends ChangeNotifier {
  bool _isLoading = false;
  bool _isPaginationLoading = false;
  bool _isTranslating = false;
  String _errorMessage = '';
  WishListModel? _wishlistModel;
  int _currentPage = 1;
  bool _hasNextPage = false;
  String _currentLanguage = 'en';

  // Translation progress
  int _translationProgress = 0;
  int _totalToTranslate = 0;

  final ApiService _apiService = ApiService();
  final AppTranslator _translator = AppTranslator();

  // Stream subscription for language changes
  StreamSubscription<String>? _languageChangeSubscription;

  // Translation cache
  final Map<String, Map<String, String>> _translationCache = {};

  // Getter methods
  bool get isLoading => _isLoading;
  bool get isPaginationLoading => _isPaginationLoading;
  bool get isTranslating => _isTranslating;
  String get errorMessage => _errorMessage;
  WishListModel? get wishlistModel => _wishlistModel;
  int get currentPage => _currentPage;
  bool get hasNextPage => _hasNextPage;
  String get currentLanguage => _currentLanguage;
  int get translationProgress => _translationProgress;
  int get totalToTranslate => _totalToTranslate;

  WhistlistProviderOfGetFavouriteProduct() {
    _initializeTranslator();
  }

  void _initializeTranslator() async {
    // Initialize with default language
    await _translator.setLanguage(_currentLanguage);

    // Listen to language change events
    _listenToLanguageChanges();
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

    // Update current language
    _currentLanguage = newLang;

    // Update translator
    await _translator.setLanguage(newLang);

    // Clear translation cache for the old language
    _translationCache.clear();

    // Re-translate existing products if any
    if (_wishlistModel != null && _wishlistModel!.data.isNotEmpty) {
      _isTranslating = true;
      _translationProgress = 0;
      _totalToTranslate =
          _wishlistModel!.data.length * 3; // title, size, condition
      notifyListeners();

      await _translateAllProducts(_wishlistModel!.data);

      _isTranslating = false;
      _translationProgress = 0;
      _totalToTranslate = 0;
      notifyListeners();
    } else {
      notifyListeners(); // Just notify UI to rebuild with new language
    }
  }

  Future<void> changeLanguage(String langCode) async {
    await _handleLanguageChange(langCode);
  }

  Future<void> _translateAllProducts(List<WishlistItem> items) async {
    if (items.isEmpty) return;

    // Initialize cache for current language
    if (!_translationCache.containsKey(_currentLanguage)) {
      _translationCache[_currentLanguage] = {};
    }

    final cache = _translationCache[_currentLanguage]!;

    for (int i = 0; i < items.length; i++) {
      final item = items[i];

      // Translate title
      final titleKey = 'title_${item.productId}';
      if (!cache.containsKey(titleKey)) {
        item.translatedTitle = await _translator.translateText(
          item.productTitle,
        );
        cache[titleKey] = item.translatedTitle!;
        _translationProgress++;
        notifyListeners();
      } else {
        item.translatedTitle = cache[titleKey];
      }

      // Translate size
      final sizeKey = 'size_${item.productSize}';
      if (!cache.containsKey(sizeKey)) {
        item.translatedSize = await _translator.translateText(item.productSize);
        cache[sizeKey] = item.translatedSize!;
        _translationProgress++;
        notifyListeners();
      } else {
        item.translatedSize = cache[sizeKey];
      }

      // Translate condition
      final conditionKey = 'condition_${item.productCondition}';
      if (!cache.containsKey(conditionKey)) {
        item.translatedCondition = await _translator.translateText(
          item.productCondition,
        );
        cache[conditionKey] = item.translatedCondition!;
        _translationProgress++;
        notifyListeners();
      } else {
        item.translatedCondition = cache[conditionKey];
      }
    }
  }

  Future<bool> getWishlistProduct() async {
    _isLoading = true;
    _currentPage = 1;
    notifyListeners();

    try {
      final response = await _apiService.get(
        ApiEndpoints.getWishList(_currentPage, 10),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _wishlistModel = WishListModel.fromJson(response.data);
        _hasNextPage = _wishlistModel?.pagination.hasNextPage ?? false;

        // Translate products
        _isTranslating = true;
        _translationProgress = 0;
        _totalToTranslate = _wishlistModel!.data.length * 3;
        notifyListeners();

        await _translateAllProducts(_wishlistModel!.data);

        _isTranslating = false;
        _isLoading = false;
        _translationProgress = 0;
        _totalToTranslate = 0;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        _errorMessage = response.data['message'] ?? 'Something went wrong';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> loadMoreWishlistProduct() async {
    if (_isPaginationLoading || !_hasNextPage) return false;

    _isPaginationLoading = true;
    _currentPage++;
    notifyListeners();

    try {
      final response = await _apiService.get(
        ApiEndpoints.getWishList(_currentPage, 10),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newWishlistModel = WishListModel.fromJson(response.data);

        // Translate new products
        final currentCount = _translationProgress;
        _totalToTranslate += newWishlistModel.data.length * 3;
        await _translateAllProducts(newWishlistModel.data);

        _wishlistModel?.data.addAll(newWishlistModel.data);
        _hasNextPage = newWishlistModel.pagination.hasNextPage;

        _isPaginationLoading = false;
        notifyListeners();
        return true;
      } else {
        _isPaginationLoading = false;
        _errorMessage = response.data['message'] ?? 'Something went wrong';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isPaginationLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Remove item from wishlist
  void removeItem(String productId) {
    if (_wishlistModel != null) {
      _wishlistModel!.data.removeWhere((item) => item.productId == productId);
      notifyListeners();
    }
  }

  void clear() {
    _wishlistModel = null;
    _currentPage = 1;
    _hasNextPage = false;
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
