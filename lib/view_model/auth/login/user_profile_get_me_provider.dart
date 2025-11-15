import 'package:flutter/material.dart';
import 'package:mussweg/core/services/api_service.dart';
import 'package:mussweg/data/model/user/user_profile_response.dart';

import '../../../core/constants/api_end_points.dart';
class UserProfileGetMeProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _message = '';
  String get message => _message;

  final ApiService _apiService = ApiService();

  UserProfileResponse? _userProfileResponse;
  UserProfileResponse? get userProfileResponse => _userProfileResponse;

  Future<void> getUserProfileDetails() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiEndpoints.getUserProfileDetails);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // parse data
        _userProfileResponse = UserProfileResponse.fromJson(response.data);
        _message = 'Profile fetched successfully';
      } else {
        _message = response.data['message'] ?? 'Something went wrong';
      }
    } catch (e) {
      _message = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
