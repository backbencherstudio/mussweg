import 'package:flutter/material.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import '../../../core/services/api_service.dart';
import '../../../data/model/user/user_model.dart';

class GetMeViewmodel extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  UserData? _user;
  UserData? get user => _user;

  String? _error;
  String? get error => _error;

  final ApiService _apiService = ApiService();

  Future<void> fetchUserData() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiEndpoints.getMe);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.data;
        final userResponse = UserResponseModel.fromJson(jsonResponse);

        if (userResponse.success && userResponse.data != null) {
          _user = userResponse.data;
        } else {
          _error = "Failed to fetch user data";
        }
      } else {
        _error = "Server error: ${response.statusCode}";
      }
    } catch (e) {
      _error = "Something went wrong: $e";
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
