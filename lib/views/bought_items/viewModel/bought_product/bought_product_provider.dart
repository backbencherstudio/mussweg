import 'package:flutter/cupertino.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/core/services/api_service.dart';
import 'package:mussweg/views/bought_items/model/cancel_bought_product_model.dart';
import 'package:mussweg/views/bought_items/model/confirm_bought_product_model.dart';
import 'package:mussweg/views/bought_items/model/pending_bought_product_model.dart';
import '../../model/allBoughtProductModel.dart';

class BoughtProductProvider extends ChangeNotifier {
  AllBoughtProductModel? _allBoughtProductModel;
  AllBoughtProductModel? get allBoughtProductModel => _allBoughtProductModel;

  PendingBoughtProductModel? _pendingBoughtProductModel;
  PendingBoughtProductModel? get pendingBoughtProductModel =>
      _pendingBoughtProductModel;

  CancelBoughtProductModel? _cancelBoughtProductModel;
  CancelBoughtProductModel? get cancelBoughtProductModel =>
      _cancelBoughtProductModel;

  ConfirmBoughtProductModel? _confirmBoughtProductModel;
  ConfirmBoughtProductModel? get confirmBoughtProductModel =>
      _confirmBoughtProductModel;

  final ApiService _apiService = ApiService();

  Future<void> allBoughtProduct() async {
    try {
      final response = await _apiService.get(ApiEndpoints.totalBoughtProduct(1, 10));
      debugPrint("API Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // response.data is already a Map, no jsonDecode needed
        _allBoughtProductModel = AllBoughtProductModel.fromJson(response.data);
        debugPrint("Success message: ${_allBoughtProductModel?.message}");
        notifyListeners();
      } else {
        debugPrint("Failed API response: ${response.data}");
      }
    } catch (error) {
      debugPrint("Error fetching all bought products: $error");
    }
  }

  Future<void> pendingBoughtProduct() async {
    try {
      final response = await _apiService.get(ApiEndpoints.boughtPendingProduct);
      debugPrint("API Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _pendingBoughtProductModel = PendingBoughtProductModel.fromJson(response.data);
        debugPrint("Success message: ${_pendingBoughtProductModel?.message}");
        notifyListeners();
      } else {
        debugPrint("Failed API response: ${response.data}");
      }
    } catch (error) {
      debugPrint("Error fetching pending bought products: $error");
    }
  }

  Future<void> confirmBoughtProduct() async {
    try {
      final response = await _apiService.get(ApiEndpoints.boughtDeliveredProduct);
      debugPrint("API Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _confirmBoughtProductModel = ConfirmBoughtProductModel.fromJson(response.data);
        debugPrint("Success message: ${_confirmBoughtProductModel?.message}");
        notifyListeners();
      } else {
        debugPrint("Failed API response: ${response.data}");
      }
    } catch (error) {
      debugPrint("Error fetching confirmed bought products: $error");
    }
  }

  Future<void> cancelBoughtProduct() async {
    try {
      final response = await _apiService.get(ApiEndpoints.boughtCancelProduct);
      debugPrint("API Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _cancelBoughtProductModel = CancelBoughtProductModel.fromJson(response.data);
        debugPrint("Success message: ${_cancelBoughtProductModel?.message}");
        notifyListeners();
      } else {
        debugPrint("Failed API response: ${response.data}");
      }
    } catch (error) {
      debugPrint("Error fetching canceled bought products: $error");
    }
  }
}
