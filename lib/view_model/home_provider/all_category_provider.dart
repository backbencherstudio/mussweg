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
  
  String _fashionCategoryId = '';
  String get fashionCategoryId => _fashionCategoryId;
  
  void setFashionCategoryId(String id){
    _fashionCategoryId = id;
    notifyListeners();
  }

  String _homeCategoryId = '';
  String get homeCategoryId => _homeCategoryId;

  void setHomeCategoryId(String id){
    _homeCategoryId = id;
    notifyListeners();
  }

  String _electronicsCategoryId = '';
  String get electronicsCategoryId => _electronicsCategoryId;

  void setElectronicsCategoryId(String id){
    _electronicsCategoryId = id;
    notifyListeners();
  }

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
        setFashionCategoryId(_categoryModel?.data.firstWhere((e) => e.categoryName == 'Fashion').categoryId ?? '');
        setHomeCategoryId(_categoryModel?.data.firstWhere((e) => e.categoryName == 'Home').categoryId ?? '');
        setElectronicsCategoryId(_categoryModel?.data.firstWhere((e) => e.categoryName == 'Electronices').categoryId ?? '');
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