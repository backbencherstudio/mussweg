import 'package:flutter/material.dart';
import 'package:mussweg/core/services/api_service.dart';
import 'package:mussweg/data/model/bids/accepted_bid_for_seller_response_model.dart';
import 'package:mussweg/data/model/bids/request_bid_for_seller_response_model.dart';
import '../../core/constants/api_end_points.dart';

class BidForSellerProvider extends ChangeNotifier {
  bool _isLoading1 = false;
  bool get isLoading1 => _isLoading1;

  bool _isLoading2 = false;
  bool get isLoading2 => _isLoading2;

  String _message = '';
  String get message => _message;

  RequestBidForSellerResponseModel? _requestBidForSellerResponseModel;
  RequestBidForSellerResponseModel? get requestBidForSellerResponseModel => _requestBidForSellerResponseModel;

  AcceptedBidForSellerResponseModel? _acceptedBidForSellerResponseModel;
  AcceptedBidForSellerResponseModel? get acceptedBidForSellerResponseModel => _acceptedBidForSellerResponseModel;

  final ApiService _apiService = ApiService();

  Future<void> getRequestedBidsForSeller() async {
    _isLoading1 = true;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiEndpoints.getRequestedBidsForSeller);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _requestBidForSellerResponseModel = RequestBidForSellerResponseModel.fromJson(response.data);
        _message = response.data['message'];

        debugPrint('Response data length: ${_requestBidForSellerResponseModel?.data.data.length}');

        _isLoading1 = false;
        notifyListeners();
      } else {
        _isLoading1 = false;
        _message = response.data['message'] ?? 'Failed to fetch bids';
        notifyListeners();
      }
    } catch (e) {
      _isLoading1 = false;
      _message = "Something went wrong: $e";
      notifyListeners();
    }
  }

  Future<void> getAcceptedBidsForSeller() async {
    _isLoading2 = true;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiEndpoints.getAcceptedBidsForSeller);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _acceptedBidForSellerResponseModel = AcceptedBidForSellerResponseModel.fromJson(response.data);
        _message = response.data['message'];

        debugPrint('Response data length: ${_acceptedBidForSellerResponseModel?.data.data.length}');

        _isLoading2 = false;
        notifyListeners();
      } else {
        _isLoading2 = false;
        _message = response.data['message'] ?? 'Failed to fetch bids';
        notifyListeners();
      }
    } catch (e) {
      _isLoading2 = false;
      _message = "Something went wrong: $e";
      notifyListeners();
    }
  }
}
