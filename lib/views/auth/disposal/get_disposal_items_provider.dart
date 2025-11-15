import 'package:flutter/material.dart';

import '../../../core/constants/api_end_points.dart';
import '../../../core/services/api_service.dart';
import '../../../data/model/disposal/disposal_item.dart';

class GetDisposalItemsProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _message = '';
  String get message => _message;

  List<DisposalItem> _disposalItems = [];
  List<DisposalItem> get disposalItems => _disposalItems;

  final ApiService _apiService = ApiService();

  Future<void> getDisposalItems({required String status}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiEndpoints.getDisposalItems(status));

      if (response.statusCode == 200) {
        // response.data is a List of disposal items directly
        if (response.data is List) {
          _disposalItems = (response.data as List)
              .map((e) => DisposalItem.fromJson(e))
              .toList();
          _message = 'Success';
        } else {
          // Unexpected success response format
          _disposalItems.clear();
          _message = 'Unexpected response format';
        }
      } else {
        // On error, the response is a Map with 'message' inside 'message' key
        if (response.data is Map && response.data['message'] is Map) {
          _message = response.data['message']['message'] ?? 'Unknown error occurred';
        } else {
          _message = 'Failed to fetch disposal items';
        }
        _disposalItems.clear();
      }
    } catch (e) {
      if (e.toString().contains('404')) {
        _message = 'No disposal requests found for the specified status.';
      } else {
        _message = "Error: $e";
      }
      _disposalItems.clear();
    }

    _isLoading = false;
    notifyListeners();
  }

}
