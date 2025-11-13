import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../core/constants/api_end_points.dart';
import '../../../core/services/api_service.dart';

class RegisterProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isOVLoading = false;
  bool get isOVLoading => _isOVLoading;

  bool _isRCLoading = false;
  bool get isRCLoading => _isRCLoading;

  String _email = '';
  String get email => _email;

  void setEmail(String email) {
    _email = email;
    debugPrint("Email: $email");
    notifyListeners();
  }

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

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

  Future<bool> registerUser({
    required String first_name,
    required String last_name,
    required String email,
    required String password,
    required String location,
  }) async {
    _isLoading = true;
    notifyListeners();

    final data = {
      "first_name": first_name,
      "last_name": last_name,
      "email": email,
      "password": password,
      "location": location,
    };

    try {
      final response = await _apiService.post(
        ApiEndpoints.register,
        data: data,
      );

      debugPrint("register response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        setEmail(email);
        _isLoading = false;
        notifyListeners();
        _errorMessage = response.data['message'];
        debugPrint("register response: ${response.data['message']}");
        notifyListeners();
        if (_errorMessage.contains('Email already exist')) {
          return false;
        } else {
          return true;
        }
      } else {
        _errorMessage = response.data['message'];
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> getOtpVerification(String otp) async {
    _isOVLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.post(ApiEndpoints.verifyEmail, data: {"token": otp, "email": _email});
      print("Response status: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _isOVLoading = false;
        _errorMessage = response.data['message'];
        notifyListeners();
        return response.data['success'];
      } else {
        _isOVLoading = false;
        _errorMessage = response.data['message'];
        notifyListeners();
        return false;
      }
    } catch (error) {
      print('Error during OTP verification: $error');
      _isOVLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> resendCode() async {
    _isRCLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.post(ApiEndpoints.resendCode, data: {"email": _email});
      print("Response status: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _isRCLoading = false;
        _errorMessage = response.data['message'];
        notifyListeners();
        return response.data['success'];
      } else {
        _isRCLoading = false;
        _errorMessage = response.data['message'];
        notifyListeners();
        return false;
      }
    } catch (error) {
      print('Error during Resend code: $error');
      _isRCLoading = false;
      notifyListeners();
      return false;
    }
  }
}
