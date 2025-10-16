import 'package:flutter/material.dart';
import 'package:mussweg/core/services/api_service.dart';
import 'package:mussweg/core/services/token_storage.dart';

import '../../../core/constants/api_end_points.dart';

class ForgetPasswordProvider extends ChangeNotifier {
  bool _isFPLoading = false;
  bool get isFPLoading => _isFPLoading;

  bool _isRPLoading = false;
  bool get isRPLoading => _isRPLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  String _otpToken = '';
  String get otpToken => _otpToken;

  void setOtpToken(String token) {
    _otpToken = token;
    notifyListeners();
  }

  String _email = '';
  String get email => _email;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  final ApiService _apiService = ApiService();

  Future<bool> forgetPassword({required String email}) async {
    _isFPLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.post(ApiEndpoints.forgetPassword, data: {"email": email});
      debugPrint("Response status: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _isFPLoading = false;
        _errorMessage = response.data['message'];
        notifyListeners();
        return response.data['success'];
      } else {
        _isFPLoading = false;
        _errorMessage = response.data['message'];
        notifyListeners();
        return false;
      }
    } catch (error) {
      print('Error during forget password: $error');
      _isFPLoading = false;
      notifyListeners();
      return false;
    }
  }
}