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

  AllSellProductModel? get allSellProductModel => _allSellProductModel;
  PendingSellProductModel? get pendingSellProductModel =>
      _pendingSellProductModel;
  CancelSellProductModel? get cancelSellProductModel => _cancelSellProductModel;
  ConfirmSellProductModel? get confirmSellProductModel =>
      _confirmSellProductModel;

  // ==========================================
  //         FETCH ALL SELL PRODUCTS
  // ==========================================
  Future<void> allBoughtProduct() async {
    try {
      final response = await _apiService.get(
        ApiEndpoints.totalSellProduct(1, 10),
      );

      debugPrint("API Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _allSellProductModel = AllSellProductModel.fromJson(response.data);
        debugPrint("Success: ${_allSellProductModel?.message}");
        notifyListeners();
      } else {
        debugPrint("Failed response: ${response.data}");
      }
    } catch (e) {
      debugPrint("Error fetching all bought items: $e");
    }
  }

  // ==========================================
  //         FETCH PENDING SELL PRODUCTS
  // ==========================================
  Future<void> pendingBoughtProduct() async {
    try {
      final response = await _apiService.get(ApiEndpoints.sellPendingProduct);

      debugPrint("API Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _pendingSellProductModel = PendingSellProductModel.fromJson(
          response.data,
        );
        debugPrint("Success:------- ${_pendingSellProductModel?.message}");
        notifyListeners();
      } else {
        debugPrint("Failed response: ${response.data}");
      }
    } catch (e) {
      debugPrint("Error fetching pending bought items: $e");
    }
  }

  // ==========================================
  //        FETCH DELIVERED (CONFIRMED)
  // ==========================================
  Future<void> confirmBoughtProduct() async {
    try {
      final response = await _apiService.get(ApiEndpoints.sellDeliveredProduct);

      debugPrint("API Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _confirmSellProductModel = ConfirmSellProductModel.fromJson(
          response.data,
        );
        debugPrint("Success: ${_confirmSellProductModel?.message}");
        notifyListeners();
      } else {
        debugPrint("Failed response: ${response.data}");
      }
    } catch (e) {
      debugPrint("Error fetching confirmed bought items: $e");
    }
  }

  // ==========================================
  //        FETCH CANCELED PRODUCTS
  // ==========================================
  Future<void> cancelBoughtProduct() async {
    try {
      final response = await _apiService.get(ApiEndpoints.sellCancelProduct);

      debugPrint("API Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _cancelSellProductModel = CancelSellProductModel.fromJson(
          response.data,
        );
        debugPrint("Success: ${_cancelSellProductModel?.message}");
        notifyListeners();
      } else {
        debugPrint("Failed response: ${response.data}");
      }
    } catch (e) {
      debugPrint("Error fetching canceled bought items: $e");
    }
  }
}
