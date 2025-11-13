import 'package:flutter/material.dart';
import 'package:mussweg/core/services/api_service.dart';
import 'package:mussweg/data/model/bids/accepted_bids_for_buyer_model.dart';
import 'package:mussweg/data/model/bids/on_progress_bids_for_buyer_model.dart';
import '../../core/constants/api_end_points.dart';

class BidForBuyerProvider extends ChangeNotifier {
  bool _isLoadingAccepted = false;
  bool get isLoadingAccepted => _isLoadingAccepted;

  bool _isLoadingOnProgress = false;
  bool get isLoadingOnProgress => _isLoadingOnProgress;

  String _message = '';
  String get message => _message;

  AcceptedBidsForBuyerModel? _acceptedBidsForBuyerModel;
  AcceptedBidsForBuyerModel? get acceptedBidsForBuyerModel =>
      _acceptedBidsForBuyerModel;

  OnProgressBidsForBuyerModel? _onProgressBidsForBuyerModel;
  OnProgressBidsForBuyerModel? get onProgressBidsForBuyerModel =>
      _onProgressBidsForBuyerModel;

  final ApiService _apiService = ApiService();

  /// Fetch Accepted Bids for Buyer
  Future<void> getAcceptedBidsForBuyer() async {
    _isLoadingAccepted = true;
    notifyListeners();
    try {
      final response = await _apiService.get(ApiEndpoints.getAcceptedBidsForBuyer);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _acceptedBidsForBuyerModel =
            AcceptedBidsForBuyerModel.fromJson(response.data);
        _message = response.data['message'] ?? '';
      } else {
        _message = response.data['message'] ?? 'Failed to fetch accepted bids';
      }
    } catch (e) {
      _message = "Error: $e";
    }
    _isLoadingAccepted = false;
    notifyListeners();
  }

  /// Fetch On Progress Bids for Buyer
  Future<void> getOnProgressBidsForBuyer() async {
    _isLoadingOnProgress = true;
    notifyListeners();
    try {
      final response = await _apiService.get(ApiEndpoints.getOnProgressBidsForBuyer);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _onProgressBidsForBuyerModel =
            OnProgressBidsForBuyerModel.fromJson(response.data);
        _message = response.data['message'] ?? '';
      } else {
        _message = response.data['message'] ?? 'Failed to fetch bids';
      }
    } catch (e) {
      _message = "Error: $e";
    }
    _isLoadingOnProgress = false;
    notifyListeners();
  }
}
