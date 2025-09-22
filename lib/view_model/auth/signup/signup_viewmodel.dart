import 'package:flutter/material.dart';

class SignUpViewModel extends ChangeNotifier {
  // Form fields
  String _email = '';
  String _password = '';

  // UI state
  bool _passwordVisible = false;
  bool _isLoading = false;
  bool _hasErrors = false;

  // Form validation
  String? _emailError;
  String? _passwordError;

  // Getters
  String get email => _email;
  String get password => _password;
  bool get passwordVisible => _passwordVisible;
  bool get isLoading => _isLoading;
  bool get hasErrors => _hasErrors;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;

  // Setters
  void setEmail(String email) {
    _email = email;
    _validateEmail();
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    _validatePassword();
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Validation methods
  void _validateEmail() {
    if (_email.isEmpty) {
      _emailError = 'Please enter your email';
    } else if (!_isValidEmail(_email)) {
      _emailError = 'Please enter a valid email address';
    } else {
      _emailError = null;
    }
    _hasErrors = _emailError != null || _passwordError != null;
  }

  void _validatePassword() {
    if (_password.isEmpty) {
      _passwordError = 'Please enter your password';
    } else if (_password.length < 6) {
      _passwordError = 'Password must be at least 6 characters';
    } else {
      _passwordError = null;
    }
    _hasErrors = _emailError != null || _passwordError != null;
  }

  bool validateForm() {
    _validateEmail();
    _validatePassword();
    _hasErrors = _emailError != null || _passwordError != null;
    notifyListeners();
    return !_hasErrors;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Signup method
  Future<bool> signUp() async {
    if (!validateForm()) {
      return false;
    }

    setLoading(true);

    try {
      // TODO: Implement actual signup logic here
      // Example:
      // await _authService.signUp(email: _email, password: _password);

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      setLoading(false);
      return true;
    } catch (e) {
      // Handle error
      _hasErrors = true;
      notifyListeners();
      setLoading(false);
      return false;
    }
  }

  // Social login methods
  Future<bool> signUpWithGoogle() async {
    setLoading(true);
    try {
      // TODO: Implement Google sign in
      await Future.delayed(const Duration(seconds: 2));
      setLoading(false);
      return true;
    } catch (e) {
      setLoading(false);
      return false;
    }
  }

  Future<bool> signUpWithApple() async {
    setLoading(true);
    try {
      // TODO: Implement Apple sign in
      await Future.delayed(const Duration(seconds: 2));
      setLoading(false);
      return true;
    } catch (e) {
      setLoading(false);
      return false;
    }
  }

  Future<bool> signUpWithFacebook() async {
    setLoading(true);
    try {
      // TODO: Implement Facebook sign in
      await Future.delayed(const Duration(seconds: 2));
      setLoading(false);
      return true;
    } catch (e) {
      setLoading(false);
      return false;
    }
  }
}