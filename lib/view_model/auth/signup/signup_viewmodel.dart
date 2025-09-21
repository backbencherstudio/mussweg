import 'package:flutter/material.dart';

class SignUpViewModel extends ChangeNotifier {
  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  // Password hide/show
  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }
}