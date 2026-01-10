import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/services/token_storage.dart';
import '../../../core/constants/api_end_points.dart';
import '../../../core/services/apple_service.dart';
import '../../../core/services/fm_token_storage.dart';

class LoginViewModel with ChangeNotifier {
  // UI states
  bool _passwordVisible = false;
  bool _rememberMe = false;
  bool _isLoadingForGoogle = false;
  bool _isLoadingForApple = false;

  // Services
  final TokenStorage _tokenStorage = TokenStorage();
  final FcmTokenStorage _fcmTokenStorage = FcmTokenStorage();

  // Getters
  bool get passwordVisible => _passwordVisible;
  bool get rememberMe => _rememberMe;
  bool get isLoadingForGoogle => _isLoadingForGoogle;
  bool get isLoadingForApple => _isLoadingForApple;
  FcmTokenStorage get fcmTokenStorage => _fcmTokenStorage;

  // UI actions
  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  void setRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  void setLoadingForGoogle(bool value) {
    _isLoadingForGoogle = value;
    notifyListeners();
  }

  void setLoadingForApple(bool value) {
    _isLoadingForApple = value;
    notifyListeners();
  }

  /// Google Sign-In
  Future<Map<String, dynamic>> googleSignIn({String? firebaseToken}) async {
    if (firebaseToken == null) {
      debugPrint("Firebase token is null.");
      return {"success": false, "message": "Firebase token is null."};
    }

    setLoadingForGoogle(true);

    final url = Uri.parse(ApiEndpoints.googleAuth);
    final fcmToken = await _fcmTokenStorage.getFcmToken();

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"idToken": firebaseToken, "fcm_token": fcmToken}),
      );

      debugPrint("Google login response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        await _tokenStorage.saveToken(data['authorization']['access_token']);
        return {"success": true, "data": ""};
      } else {
        return {"success": false, "message": "Login failed. Please try again."};
      }
    } catch (error) {
      debugPrint("Google login error: $error");
      return {"success": false, "message": "Login failed: $error"};
    } finally {
      setLoadingForGoogle(false);
    }
  }

  /// Apple Sign-In
  Future<Map<String, dynamic>> appleSignIn() async {
    setLoadingForApple(true);

    try {
      // Login via Apple service
      final userCredential = await AuthServicesApple().loginWithApple();

      if (userCredential == null || userCredential.user == null) {
        return {"success": false, "message": "Apple sign-in failed."};
      }

      // Get Firebase ID token
      final firebaseToken = await userCredential.user?.getIdToken();
      if (firebaseToken == null) {
        return {"success": false, "message": "Firebase token is null."};
      }

      // Get FCM token
      final fcmToken = await _fcmTokenStorage.getFcmToken();

      // Send token to backend
      final url = Uri.parse(ApiEndpoints.appleAuth);
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"idToken": firebaseToken, "fcm_token": fcmToken}),
      );

      debugPrint("Apple login response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        await _tokenStorage.saveToken(data['authorization']['access_token']);
        return {"success": true, "data": ""};
      } else {
        return {"success": false, "message": "Apple login failed on backend."};
      }
    } catch (error) {
      debugPrint("Apple login error: $error");
      return {"success": false, "message": "Apple login failed: $error"};
    } finally {
      setLoadingForApple(false);
    }
  }
}
