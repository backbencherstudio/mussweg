// user_all_products_provider.dart
import 'package:flutter/material.dart';
import '../../../core/constants/api_end_points.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/translator_service.dart';
import '../../../data/user_all_products/user_all_products_viewmodel.dart';

class UserAllProductsProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isTranslating = false;
  String _errorMessage = '';
  UserAllProductsViewmodel? _userAllProductsViewmodel;
  String _currentLanguage = 'en';

  final ApiService _apiService = ApiService();
  final AppTranslator _translator = AppTranslator();

  // Translation cache
  final Map<String, Map<String, String>> _translationCache = {};

  bool get isLoading => _isLoading;
  bool get isTranslating => _isTranslating;
  String get errorMessage => _errorMessage;
  UserAllProductsViewmodel? get userAllProductsViewmodel => _userAllProductsViewmodel;
  String get currentLanguage => _currentLanguage;

  Future<void> changeLanguage(String langCode) async {
    if (_currentLanguage == langCode) return;

    _currentLanguage = langCode;
    await _translator.setLanguage(langCode);

    // Clear translation cache for the new language
    _translationCache.clear();

    // Re-translate existing products if any
    if (_userAllProductsViewmodel != null && _userAllProductsViewmodel!.data.isNotEmpty) {
      _isTranslating = true;
      notifyListeners();

      await _translateAllProducts(_userAllProductsViewmodel!.data);

      _isTranslating = false;
      notifyListeners();
    }
  }

  Future<void> _translateAllProducts(List<ProductData> items) async {
    if (items.isEmpty) return;

    // Initialize cache for current language
    if (!_translationCache.containsKey(_currentLanguage)) {
      _translationCache[_currentLanguage] = {};
    }

    final cache = _translationCache[_currentLanguage]!;

    for (var item in items) {
      // Translate title
      final titleKey = 'title_${item.id}';
      if (!cache.containsKey(titleKey)) {
        item.translatedTitle = await _translator.translateText(item.title);
        cache[titleKey] = item.translatedTitle!;
      } else {
        item.translatedTitle = cache[titleKey];
      }

      // Translate size
      final sizeKey = 'size_${item.size}';
      if (!cache.containsKey(sizeKey)) {
        item.translatedSize = await _translator.translateText(item.size);
        cache[sizeKey] = item.translatedSize!;
      } else {
        item.translatedSize = cache[sizeKey];
      }

      // Translate condition
      final conditionKey = 'condition_${item.condition}';
      if (!cache.containsKey(conditionKey)) {
        item.translatedCondition = await _translator.translateText(item.condition);
        cache[conditionKey] = item.translatedCondition!;
      } else {
        item.translatedCondition = cache[conditionKey];
      }
    }
  }

  Future<bool> getAllUserProduct() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiEndpoints.userAllProducts);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _userAllProductsViewmodel = UserAllProductsViewmodel.fromJson(response.data);

        // Translate products
        _isTranslating = true;
        notifyListeners();

        await _translateAllProducts(_userAllProductsViewmodel!.data);

        _isTranslating = false;
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
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
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

  // Clear all data
  void clear() {
    _userAllProductsViewmodel = null;
    _translationCache.clear();
    notifyListeners();
  }

  // Helper method to refresh data
  Future<bool> refreshData() async {
    return await getAllUserProduct();
  }
}