import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/constants/api_end_points.dart';
import '../../core/services/api_service.dart';

enum WishlistAction {
  added,
  removed,
  none,
}

class WishlistCreate extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  WishlistAction _lastAction = WishlistAction.none;
  WishlistAction get lastAction => _lastAction;

  Future<bool> createWishListProduct(String productId) async {
    _isLoading = true;
    _errorMessage = '';
    _lastAction = WishlistAction.none;
    notifyListeners();

    final data = {
      "product_id": productId,
    };

    try {
      final response = await _apiService.post(
        ApiEndpoints.createWishListProduct,
        data: data,
      );

      _isLoading = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final success = response.data['success'] == true;
        final message = response.data['message']?.toString() ?? '';

        _errorMessage = message;

        // 🔍 Detect action from backend message
        if (message.toLowerCase().contains('added')) {
          _lastAction = WishlistAction.added;
        } else if (message.toLowerCase().contains('removed')) {
          _lastAction = WishlistAction.removed;
        }

        notifyListeners();
        return success;
      }

      _errorMessage = response.data['message'] ?? 'Something went wrong';
      notifyListeners();
      return false;
    } on DioException catch (e) {
      _isLoading = false;
      _errorMessage =
          e.response?.data['message']?.toString() ??
              'Unauthorized: Please check your credentials.';
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
