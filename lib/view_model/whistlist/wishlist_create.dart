import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/constants/api_end_points.dart';
import '../../core/services/api_service.dart';
import '../../data/model/whistlist/favourite_product_model.dart';

class WishlistCreate extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  final ApiService _apiService = ApiService();

  Future<bool> createWishListProduct(String productId) async {
    _isLoading = true;
    notifyListeners();

    final data = {
      "product_id": productId,
    };

    try {
      final response = await _apiService.post(ApiEndpoints.createWishListProduct,data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        notifyListeners();
        _errorMessage = response.data['message'];
        notifyListeners();
        return response.data['success'];
      } else {
        _isLoading = false;
        _errorMessage = response.data['message'];
        notifyListeners();
        return false;
      }
    } on DioException catch (e) {
      final serverMessage = e.response?.data['message']['message'] ?? "Unauthorized: Please check your credentials.";
      _errorMessage = serverMessage;
      _isLoading = false;
      notifyListeners();
      return false;
    }
    catch (e) {
      debugPrint("Error for fetching category based product: $e");
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}