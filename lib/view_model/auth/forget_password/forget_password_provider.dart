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

  Future<void> setOtpToken(String token) async {
    _otpToken = token;
    debugPrint("Otp Token: $token");
    notifyListeners();
  }

  String _email = '';
  String get email => _email;

  void setEmail(String email) {
    _email = email;
    debugPrint("Email: $email");
    notifyListeners();
  }

  bool _isPassObscured = true;
  bool get isPassObscured => _isPassObscured;

  bool _isConfirmPassObscured = true;
  bool get isConfirmPassObscured => _isConfirmPassObscured;

  bool _passwordVisible = false;
  bool get passwordVisible => _passwordVisible;

  void togglePassObscured() {
    _isPassObscured = !_isPassObscured;
    notifyListeners();
  }

  void toggleConfirmPassObscured() {
    _isConfirmPassObscured = !_isConfirmPassObscured;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  final ApiService _apiService = ApiService();

  Future<bool> forgetPassword({required String email}) async {
    _isFPLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.post(
        ApiEndpoints.forgetPassword,
        data: {"email": email},
      );
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

  Future<bool> resetPassword({required String password}) async {
    _isRPLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.post(
        ApiEndpoints.resetPassword,
        data: {
          "email": _email,
          "token": _otpToken,
          "password": password,
        },
      );
      debugPrint("Response status: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _isRPLoading = false;
        _errorMessage = response.data['message'];
        notifyListeners();
        return response.data['success'];
      } else {
        _isRPLoading = false;
        _errorMessage = response.data['message'];
        notifyListeners();
        return false;
      }
    } catch (error) {
      print('Error during reset password: $error');
      _isRPLoading = false;
      notifyListeners();
      return false;
    }
  }
}
