import 'package:flutter/material.dart';
import '../../core/constants/api_end_points.dart';
import '../../core/services/api_service.dart';

class BoostProductCreateProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  final ApiService _apiService = ApiService();

  Future<bool> createBoostProduct(String productId) async {
    _isLoading = true;
    notifyListeners();

    final data = {
      "product_id": productId,
      "days": 3
    };

    try {
      final response = await _apiService.post(ApiEndpoints.createBoost(productId),data: data);

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
    } catch (e) {
      debugPrint("Error for fetching category based product: $e");
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}