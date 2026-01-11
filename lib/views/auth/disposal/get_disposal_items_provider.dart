import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mussweg/core/services/token_storage.dart';

import '../../../core/constants/api_end_points.dart';
import '../../../core/services/api_service.dart';
import '../../../data/model/disposal/disposal_item.dart';
import 'package:http/http.dart' as http;

class GetDisposalItemsProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _message = '';
  String get message => _message;

  List<DisposalItem> _disposalItems = [];
  List<DisposalItem> get disposalItems => _disposalItems;

  final ApiService _apiService = ApiService();

  final TokenStorage _tokenStorage = TokenStorage();
  Future<String> stripPayForBoost(String productId) async {
    try {
      final token = await _tokenStorage.getToken();
      final url = Uri.parse(
        ApiEndpoints.stripPayment(productId),
      ).replace(queryParameters: {"type": "disposal"});

      final response = await http.post(
        url,
        headers: {"Authorization": "Bearer $token"},
      );

      final decodeData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Stripe success message ${decodeData['message']}");
        debugPrint("Stripe success message ${response.body}");
        debugPrint("Stripe success message ${decodeData}");
        return decodeData['clientSecret'];
      } else {
        debugPrint("Stripe failed message ${decodeData['message']}");
        throw Exception(decodeData['message']);
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> getDisposalItems({required String status}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.get(
        ApiEndpoints.getDisposalItems(status),
      );

      if (response.statusCode == 200) {
        // response.data is a List of disposal items directly
        if (response.data is List) {
          _disposalItems =
              (response.data as List)
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
          _message =
              response.data['message']['message'] ?? 'Unknown error occurred';
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
