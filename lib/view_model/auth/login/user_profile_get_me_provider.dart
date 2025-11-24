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

      debugPrint('=== response code : ${response.statusCode}');
      debugPrint('=== response data : ${response.data}');

      // Check if the response code is valid
      if (response.statusCode == 200 || response.statusCode == 201) {

        // Ensure response.data is a Map and parse it accordingly
        if (response.data is Map<String, dynamic>) {
          // If the response has the 'data' field, parse it
          _userProfileResponse = UserProfileResponse.fromJson(response.data);

          // Log user profile details
          debugPrint(' --- boom : ${_userProfileResponse?.data.name} ---');
          debugPrint(' --- boom : ${_userProfileResponse?.data.id} ---');
          debugPrint(' --- boom : ${_userProfileResponse?.data.coverPhotoUrl} ---');
          debugPrint(' --- boom : ${_userProfileResponse?.data.rating} ---');
          debugPrint(' --- boom : ${_userProfileResponse?.data.reviewCount} ---');
          _message = 'Profile fetched successfully';
        } else {
          _message = 'Invalid data format';
        }
      } else {
        _message = response.data['message'] ?? 'Something went wrong';
      }
    } catch (e) {
      _message = 'Error: $e';
      debugPrint('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
