import 'package:flutter/material.dart';
import 'package:mussweg/core/services/api_service.dart';
import 'package:mussweg/data/model/bids/bids_response.dart';

import '../../core/constants/api_end_points.dart';
class PlaceABidProvider extends ChangeNotifier {
  bool _isBidding = false;
  bool get isBidding => _isBidding;

  Future<void> setIsBidding(bool value) async {
    _isBidding = value;
    notifyListeners();
  }

  bool _isGetBidLoading = false;
  bool get isGetBidLoading => _isGetBidLoading;

  String _getBidMssg = '';
  String get getBidMssg => _getBidMssg;

  BidsResponse? _bidsResponse;
  BidsResponse? get bidsResponse => _bidsResponse;

  final ApiService _apiService = ApiService();

  Future<void> getAllBidsForProduct(String id) async {
    _isGetBidLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiEndpoints.getProductBids(id));
      if (response.statusCode == 200 || response.statusCode == 201) {
        _isGetBidLoading = false;
        _getBidMssg = response.data['message'];
        _bidsResponse = BidsResponse.fromJson(response.data);
        notifyListeners();
      } else {
        _isGetBidLoading = false;
        _getBidMssg = response.data['message'];
        notifyListeners();
      }
    } catch (e) {
      _isGetBidLoading = false;
      _getBidMssg = "Something went wrong: $e";
      notifyListeners();
    } finally {
      _isGetBidLoading = false;
      notifyListeners();
    }
  }

  bool _isCreateBidLoading = false;
  bool get isCreateBidLoading => _isCreateBidLoading;

  String _message = '';
  String get message => _message;

  Future<bool> createBidByProductId(String id, String amount) async {
    _isCreateBidLoading = true;
    notifyListeners();

    final data = {
      "product_id": id,
      "bid_amount": amount
    };

    try {
      final response = await _apiService.post(ApiEndpoints.createBid, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _isCreateBidLoading = false;
        _message = response.data['message'];
        notifyListeners();
        return response.data['success'];
      } else if (response.statusCode == 409){
        _isCreateBidLoading = false;
        _message = 'Bid amount must be less than product price';
        notifyListeners();
        return false;
      } else {
        _isCreateBidLoading = false;
        _message = response.data['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isCreateBidLoading = false;
      if (e.toString().contains('409')){
        _message = 'Bid amount must be less than product price';
        notifyListeners();
        return false;
      } else {
        _message = "Something went wrong: $e";
        notifyListeners();
        return false;
      }
    }
  }
}