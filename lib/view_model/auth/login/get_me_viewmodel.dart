import 'package:flutter/material.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import '../../../core/services/api_service.dart';
import '../../../data/model/user/user_model.dart';

class GetMeViewmodel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _loading = false;
  bool get loading => _loading;

  UserData? _user;
  UserData? get user => _user;

  String? _error;
  String? get error => _error;

  Future<void> fetchUserData() async {
    _setLoading(true);

    try {
      final response = await _apiService.get(ApiEndpoints.getMe);

      if (response.statusCode == 200) {
        final jsonResponse = response.data as Map<String, dynamic>;
        final userResponse = UserResponseModel.fromJson(jsonResponse);

        if (userResponse.success && userResponse.data != null) {
          _user = userResponse.data!;
          _error = null;
        } else {
          _error = "Failed to load user data";
          _user = null;
        }
      } else {
        _error = "Server error (${response.statusCode})";
        _user = null;
      }
    } catch (e) {
      _error = "Something went wrong: $e";
      _user = null;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> refreshUser() async {
    await fetchUserData();
  }
}
