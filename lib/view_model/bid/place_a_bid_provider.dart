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

  List<Bid> _acceptedBids = [];
  List<Bid> _pendingBids = [];

  List<Bid> get acceptedBids => _acceptedBids;
  List<Bid> get pendingBids => _pendingBids;

  Future<void> getAllBidsForProduct(String id) async {
    _isGetBidLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiEndpoints.getProductBids(id));
      debugPrint("Raw response data type: ${response.data.runtimeType}");
      debugPrint("Raw response data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _bidsResponse = BidsResponse.fromJson(response.data);

        // Separate accepted and pending bids
        _acceptedBids = _bidsResponse?.bids
            .where((bid) => bid.status.toUpperCase() == "ACCEPTED")
            .toList() ??
            [];

        _pendingBids = _bidsResponse?.bids
            .where((bid) => bid.status.toUpperCase() == "PENDING")
            .toList() ??
            [];

        debugPrint('Accepted bids: ${_acceptedBids.length}');
        debugPrint('Pending bids: ${_pendingBids.length}');

        _isGetBidLoading = false;
        notifyListeners();
      } else {
        _getBidMssg = response.data['message'];
        _isGetBidLoading = false;
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
        if (response.data.toString().contains('409')) {
          _message = response.data['message']['message'];
        } else {
          _message = response.data['message'];
        }
        notifyListeners();
        return response.data['success'];
      } else if (response.statusCode == 409){
        _isCreateBidLoading = false;
        _message = response.data['message']['message'];
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
        _message = 'You cannot bid on your own product';
        debugPrint("Error creating bid: $_message");
        notifyListeners();
        return false;
      } else {
        _message = "Something went wrong: $e";
        notifyListeners();
        return false;
      }
    }
  }

  bool _isUpdating1 = false;
  bool get isUpdating1 => _isUpdating1;

  bool _isUpdating2 = false;
  bool get isUpdating2 => _isUpdating2;

  Future<bool> updateBidStatusByProductId(String productId, String status) async {

    if (status == 'ACCEPTED') {
      _isUpdating1 = true;
      notifyListeners();
    } else {
      _isUpdating2 = true;
      notifyListeners();
    }

    status == 'ACCEPTED' ? _isUpdating1 = true : _isUpdating2 = true;
    notifyListeners();

    final data = {
      "status": status
    };

    try {
      final response = await _apiService.patch(ApiEndpoints.updateBidStatus(productId), data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        status == 'ACCEPTED' ? _isUpdating1 = false : _isUpdating2 = false;
        _message = response.data['message'];
        notifyListeners();
        return response.data['success'];
      } else {
        status == 'ACCEPTED' ? _isUpdating1 = false : _isUpdating2 = false;
        _message = response.data['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      status == 'ACCEPTED' ? _isUpdating1 = false : _isUpdating2 = false;
        _message = "Something went wrong: $e";
        notifyListeners();
        return false;
    }
  }
}