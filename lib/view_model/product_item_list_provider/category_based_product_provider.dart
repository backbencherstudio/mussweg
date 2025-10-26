import 'package:flutter/material.dart';
import 'package:mussweg/data/model/home/category_based_product_model.dart';
import 'package:mussweg/data/model/home/category_model.dart';

import '../../core/constants/api_end_points.dart';
import '../../core/services/api_service.dart';

class CategoryBasedProductProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  String _categoryTitle = '';
  String get categoryTitle => _categoryTitle;

  void setCategoryTitle(String title) {
    _categoryTitle = title;
    notifyListeners();
  }

  String _categoryId = '';
  String get categoryId => _categoryId;

  Future<void> setCategoryId(String id) async {
    _categoryId = id;
    notifyListeners();
  }

  CategoryBasedProductModel? _categoryBasedProductModel;
  CategoryBasedProductModel? get categoryBasedProductModel => _categoryBasedProductModel;

  final ApiService _apiService = ApiService();

  int _currentPage = 1;
  int get currentPage => _currentPage;

  bool _hasNextPage = false;
  bool get hasNextPage => _hasNextPage;

  bool _isPaginationLoading = false;
  bool get isPaginationLoading => _isPaginationLoading;

  Future<bool> getCategoryBasedProduct() async {
    _isLoading = true;
    _currentPage = 1;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiEndpoints.getProductsByCategory(_categoryId, _currentPage, 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        _categoryBasedProductModel = CategoryBasedProductModel.fromJson(response.data);
        _hasNextPage = _categoryBasedProductModel?.pagination.hasNextPage ?? false;
        _errorMessage = response.data['message'] ?? '';
        notifyListeners();
        return response.data['success'];
      } else {
        _isLoading = false;
        _errorMessage = response.data['message'] ?? 'Something went wrong';
        notifyListeners();
        return false;
      }
    } catch (e) {
      debugPrint("Error fetching category-based products: $e");
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> loadMoreCategoryBasedProduct() async {
    if (_isPaginationLoading || !_hasNextPage) {
      return false;
    }

    _isPaginationLoading = true;
    notifyListeners();

    try {
      _currentPage++;
      final response = await _apiService.get(ApiEndpoints.getProductsByCategory(_categoryId, _currentPage, 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newCategoryBasedProductModel = CategoryBasedProductModel.fromJson(response.data);
        _categoryBasedProductModel?.data.addAll(newCategoryBasedProductModel.data);
        _hasNextPage = newCategoryBasedProductModel.pagination.hasNextPage;

        _isPaginationLoading = false;
        _errorMessage = response.data['message'] ?? '';
        notifyListeners();
        return response.data['success'];
      } else {
        _isPaginationLoading = false;
        _errorMessage = response.data['message'] ?? 'Something went wrong';
        notifyListeners();
        return false;
      }
    } catch (e) {
      debugPrint("Error loading more category-based products: $e");
      _errorMessage = e.toString();
      _isPaginationLoading = false;
      notifyListeners();
      return false;
    }
  }
}
