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

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userResponse = MyDashboardResponseModel.fromJson(response.data);

        if (userResponse.success && userResponse.data != null) {
          _myDashboardResponseModel = userResponse;
          _error = null;
        } else {
          _error = "Failed to load My dashboard data";
          _myDashboardResponseModel = null;
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