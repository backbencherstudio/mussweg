import 'package:flutter/material.dart';
import 'package:mussweg/data/model/client_dashboard/client_dashboard_details_model.dart';

import '../../core/constants/api_end_points.dart';
import '../../core/services/api_service.dart';

class ClientDashboardDetailsProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _loading = false;
  bool get loading => _loading;

  String _clientId = '';
  String get clientId => _clientId;

  void setClientId(String id) {
    _clientId = id;
    notifyListeners();
  }

  ClientDashboardDetailsModel? _clientDashboardDetailsModel;
  ClientDashboardDetailsModel? get clientDashboardDetailsModel => _clientDashboardDetailsModel;

  String? _error;
  String? get error => _error;

  Future<void> fetchClientData() async {
    _setLoading(true);

    try {
      final response = await _apiService.get(ApiEndpoints.getClientDetails(_clientId));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userResponse = ClientDashboardDetailsModel.fromJson(response.data);

        if (userResponse.success && userResponse.data != null) {
          _clientDashboardDetailsModel = userResponse;
          _error = null;
        } else {
          _error = "Failed to load Client data";
          _clientDashboardDetailsModel = null;
        }
      } else {
        _error = "Server error (${response.statusCode})";
        _clientDashboardDetailsModel = null;
      }

      notifyListeners();
    } catch (e) {
      _error = "Something went wrong: $e";
      _clientDashboardDetailsModel = null;
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