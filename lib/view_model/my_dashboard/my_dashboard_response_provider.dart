
import 'package:flutter/material.dart';
import 'package:mussweg/data/model/user/my_dashboard_response_model.dart';

import '../../core/constants/api_end_points.dart';
import '../../core/services/api_service.dart';

class MyDashboardResponseProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _loading = false;
  bool get loading => _loading;

  MyDashboardResponseModel? _myDashboardResponseModel;
  MyDashboardResponseModel? get myDashboardResponseModel => _myDashboardResponseModel;

  String? _error;
  String? get error => _error;

  Future<void> fetchMyDashboardData() async {
    _setLoading(true);

    try {
      final response = await _apiService.get(ApiEndpoints.getMyDashboardDetails);

      debugPrint('=== Raw Response Data: ${response.data}');
      debugPrint('=== Response Status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          // Log parsing process
          debugPrint('=== Parsing Response...');
          _myDashboardResponseModel = MyDashboardResponseModel.fromJson(response.data);

          debugPrint('=== Parsing Success: ${_myDashboardResponseModel?.success}');
          debugPrint('=== Profile Name: ${_myDashboardResponseModel?.data.profile.name}');
          debugPrint('=== Product Count: ${_myDashboardResponseModel?.data.products.data.length}');
          debugPrint('=== First Product Title: ${_myDashboardResponseModel?.data.products.data[0].productTitle}');

          _error = null;
        } catch (e) {
          debugPrint('Error parsing response: $e');
          _myDashboardResponseModel = null;
          _error = 'Error parsing response: $e';
        }
      } else {
        _error = "Server error (${response.statusCode})";
        _myDashboardResponseModel = null;
      }

      notifyListeners();
    } catch (e) {
      _error = "Something went wrong: $e";
      _myDashboardResponseModel = null;
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