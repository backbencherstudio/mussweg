import 'package:flutter/material.dart';
import 'package:mussweg/data/model/home/category_based_product_model.dart';
import 'package:mussweg/data/model/home/category_model.dart';

import '../../../core/constants/api_end_points.dart';
import '../../../core/services/api_service.dart';
import '../../../data/user_all_products/user_all_products_viewmodel.dart';

class UserAllProductsProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  UserAllProductsViewmodel ? _userAllProductsViewmodel;
  UserAllProductsViewmodel? get userAllProductsViewmodel => _userAllProductsViewmodel;

  final ApiService _apiService = ApiService();

  Future<bool> getAllUserProduct() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiEndpoints.userAllProducts);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        notifyListeners();
        _errorMessage = response.data['message'];
        _userAllProductsViewmodel = UserAllProductsViewmodel.fromJson(response.data);
        notifyListeners();
        return response.data['success'];
      } else {
        _isLoading = false;
        _errorMessage = response.data['message'];
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
}