import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:io' show Platform;
class AuthServicesApple {
  // Singleton pattern
  AuthServicesApple._internal();
  static final AuthServicesApple _instance = AuthServicesApple._internal();
  factory AuthServicesApple() => _instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> loginWithApple() async {
    try {
      WebAuthenticationOptions? webOptions;

      // Android requires webAuthenticationOptions
      if (!kIsWeb && !Platform.isIOS) {
        webOptions = WebAuthenticationOptions(
          clientId: 'com.sva.delta.mussweg',
          redirectUri: Uri.parse(
            'https://your-app-redirect-uri.com/callbacks/sign_in_with_apple',
          ),
        );
      }

      // Optional for Web
      if (kIsWeb) {
        webOptions = WebAuthenticationOptions(
          clientId: 'com.sva.delta.mussweg', // Apple Services ID
          redirectUri: Uri.parse(
            'https://your-app-redirect-uri.com/callbacks/sign_in_with_apple',
          ),
        );
      }

      // Step 1: Get Apple ID credential
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: webOptions,
      );

      if (appleCredential.identityToken == null) {
        debugPrint("Apple login failed: identityToken is null");
        return null;
      }

      // Step 2: Create Firebase credential
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Step 3: Sign in to Firebase
      return await _auth.signInWithCredential(oauthCredential);
    } catch (e) {
      debugPrint("Apple login failed: $e");
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint("Apple logout failed: $e");
    }
  }

  Future<String?> getFirebaseIdToken() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;
      return await user.getIdToken();
    } catch (e) {
      debugPrint("Get Firebase ID token failed: $e");
      return null;
    }
  }
}
