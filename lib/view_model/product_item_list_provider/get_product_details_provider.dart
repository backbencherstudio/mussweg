import 'package:flutter/material.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/data/model/product/product_details_response.dart';
import '../../../core/services/api_service.dart';

class GetProductDetailsProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _loading = false;
  bool get loading => _loading;

  String? _message;
  String? get message => _message;

  ProductDetailsResponse? _productDetailsResponse;
  ProductDetailsResponse? get productDetailsResponse => _productDetailsResponse;

  Future<void> getProductDetails(String id) async {
    _setLoading(true);

    try {
      final response = await _apiService.get(ApiEndpoints.getProductDetailsById(id));

      if (response.statusCode == 200 || response.statusCode == 201) {
        _setLoading(false);
        _productDetailsResponse = ProductDetailsResponse.fromJson(response.data);
        _message = response.data['message'];
        notifyListeners();
      } else {
        _setLoading(false);
        _message = response.data['message'];
        notifyListeners();
      }

      notifyListeners();

    } catch (e) {
      _setLoading(false);
      _message = "Something went wrong: $e";
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
