import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/core/services/api_service.dart';

import '../model/allSellProductModel.dart';
import '../model/pending_sell_product_model.dart';
import '../model/cancel_sell_product_model.dart';
import '../model/confirm_sell_product_model.dart';

class SellingItemScreenProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  AllSellProductModel? _allSellProductModel;
  PendingSellProductModel? _pendingSellProductModel;
  CancelSellProductModel? _cancelSellProductModel;
  ConfirmSellProductModel? _confirmSellProductModel;

  bool isLoading = false;
  String? errorMessage;

  /// Getters
  AllSellProductModel? get allSellProductModel => _allSellProductModel;
  PendingSellProductModel? get pendingSellProductModel => _pendingSellProductModel;
  CancelSellProductModel? get cancelSellProductModel => _cancelSellProductModel;
  ConfirmSellProductModel? get confirmSellProductModel => _confirmSellProductModel;

  // =====================================================
  //                 Helper to Handle Loading/Error
  // =====================================================
  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    errorMessage = message;
    notifyListeners();
  }

  // =====================================================
  //                    FETCH ALL PRODUCTS
  // =====================================================
  Future<void> allSelProduct() async {
    _setLoading(true);
    try {
      final response = await _apiService.get(ApiEndpoints.totalSellProduct(1, 10));
      debugPrint("API Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _allSellProductModel = AllSellProductModel.fromJson(response.data);
        debugPrint("All products fetched: ${_allSellProductModel?.data?.length}");
        _setError(null);
      } else {
        _setError("Failed to fetch all sold products");
      }
    } catch (e) {
      debugPrint("Error fetching all products: $e");
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // =====================================================
  //                 FETCH PENDING PRODUCTS
  // =====================================================
  Future<void> pendingSelProduct() async {
    _setLoading(true);
    try {
      final response = await _apiService.get(ApiEndpoints.sellPendingProduct);
      debugPrint("API Response: ${response.data}");

      final decodeData = jsonDecode(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _pendingSellProductModel = PendingSellProductModel.fromJson(response.data);
        debugPrint("Pending products fetched: ${_pendingSellProductModel?.data?.length}");
        debugPrint("Message: ${decodeData['message']}");
        _setError(null);
      } else {
        debugPrint("Failed message: ${decodeData['message']}");
        _setError("Failed to fetch pending products");
      }
    } catch (e) {
      debugPrint("Error fetching pending products: $e");
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // =====================================================
  //                FETCH CONFIRMED PRODUCTS
  // =====================================================
  Future<void> confirmSelProduct() async {
    _setLoading(true);
    try {
      final response = await _apiService.get(ApiEndpoints.sellDeliveredProduct);
      debugPrint("API Response: ${response.data}");

      final decodeData = jsonDecode(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _confirmSellProductModel = ConfirmSellProductModel.fromJson(response.data);
        debugPrint("Confirmed products fetched: ${_confirmSellProductModel?.data?.length}");
        debugPrint("Message: ${decodeData['message']}");
        _setError(null);
      } else {
        debugPrint("Failed message: ${decodeData['message']}");
        _setError("Failed to fetch confirmed products");
      }
    } catch (e) {
      debugPrint("Error fetching confirmed products: $e");
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // =====================================================
  //                  FETCH CANCELED PRODUCTS
  // =====================================================
  Future<void> cancelSelProduct() async {
    _setLoading(true);
    try {
      final response = await _apiService.get(ApiEndpoints.sellCancelProduct);
      debugPrint("API Response: ${response.data}");

      final decodeData = jsonDecode(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _cancelSellProductModel = CancelSellProductModel.fromJson(response.data);
        debugPrint("Canceled products fetched: ${_cancelSellProductModel?.data?.length}");
        debugPrint("Message: ${decodeData['message']}");
        _setError(null);
      } else {
        debugPrint("Failed message: ${decodeData['message']}");
        _setError("Failed to fetch canceled products");
      }
    } catch (e) {
      debugPrint("Error fetching canceled products: $e");
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
}
