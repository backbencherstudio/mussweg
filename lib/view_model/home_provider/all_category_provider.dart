import 'package:flutter/material.dart';
import 'package:mussweg/data/model/home/category_model.dart';

import '../../core/constants/api_end_points.dart';
import '../../core/services/api_service.dart';

class AllCategoryProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  CategoryModel? _categoryModel;
  CategoryModel? get categoryModel => _categoryModel;

  final ApiService _apiService = ApiService();

  Future<bool> getAllCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiEndpoints.getAllCategory);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        notifyListeners();
        _errorMessage = response.data['message'];
        _categoryModel = CategoryModel.fromJson(response.data);
        notifyListeners();
        return response.data['success'];
      } else {
        _isLoading = false;
        _errorMessage = response.data['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      debugPrint("Error for fetching category: $e");
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}