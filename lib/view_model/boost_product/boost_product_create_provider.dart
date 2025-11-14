import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/constants/api_end_points.dart';
import '../../core/services/api_service.dart';

class BoostProductCreateProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  final ApiService _apiService = ApiService();

  String _boostTier = '';

  String get boostTier => _boostTier;

  void setBoostTier(String value) {
    _boostTier = value;
    debugPrint('---- Boost Tier : $boostTier ----');
    notifyListeners();
  }

  String _productId = '3';

  String get productId => _productId;

  void setProductId(String value) {
    _productId = value;
    debugPrint('---- Boost Tier : $_productId ----');
    notifyListeners();
  }

  /// ===============================================================
  String _image = '';

  String get image => _image;

  void setImage(String value) {
    _image = value;
    notifyListeners();
  }

  String _title = '';

  String get title => _title;

  void setTitle(String value) {
    _title = value;
    notifyListeners();
  }

  String _size = '';

  String get size => _size;

  void setSize(String value) {
    _size = value;
    notifyListeners();
  }

  String _condition = '';

  String get condition => _condition;

  void setCondition(String value) {
    _condition = value;
    notifyListeners();
  }

  String _time = '';

  String get time => _time;

  void setTime(String value) {
    _time = value;
    notifyListeners();
  }

  String _boostTime = '';

  String get boostTime => _boostTime;

  void setBoostTime(String value) {
    _boostTime = value;
    debugPrint('---- Boost Time : $boostTime ----');
    notifyListeners();
  }

  String _price = '';

  String get price => _price;

  void setPrice(String value) {
    _price = value;
    notifyListeners();
  }

  /// ===============================================================

  Future<bool> createBoostProduct() async {
    _isLoading = true;
    notifyListeners();

    final data = {
      "product_id": _productId,
      "boost_tier": _boostTier
    };

    try {
      final response = await _apiService.post(
          ApiEndpoints.createBoost, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        notifyListeners();
        if (response.data['success'] == false) {
          _errorMessage = response.data['message']['message'];
          notifyListeners();
          return false;
        }
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
      debugPrint("Error for creating boost product: $e");

      if (e is DioException) {
        final serverMessage = e.response?.data?['message']?['message'];
        if (serverMessage != null) {
          _errorMessage = serverMessage;
        } else {
          _errorMessage = "Something went wrong";
        }
      } else {
        _errorMessage = e.toString();
      }

      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}