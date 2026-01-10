import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../views/notification/notification_screen_provider.dart';
import 'fm_token_storage.dart';

class NotificationService {
  static final NotificationService _instance =
  NotificationService._internal();

  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FcmTokenStorage _fcmTokenStorage = FcmTokenStorage();

  Future<void> init(GlobalKey<NavigatorState> navigatorKey) async {
    await _requestPermission();
    await _waitForApnsTokenIfIOS(); // 🔥 iOS FIX
    await _getAndSaveFcmToken();
    _setupListeners(navigatorKey);
  }

  // ---------------------------------------------------------------------------
  // Permission
  // ---------------------------------------------------------------------------

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint(
      'User granted permission: ${settings.authorizationStatus}',
    );
  }

  // ---------------------------------------------------------------------------
  // iOS APNs handling (CRITICAL)
  // ---------------------------------------------------------------------------

  Future<void> _waitForApnsTokenIfIOS() async {
    if (!Platform.isIOS) return;

    String? apnsToken;

    while (apnsToken == null) {
      apnsToken = await _messaging.getAPNSToken();
      if (apnsToken == null) {
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }

    debugPrint('APNs token ready');
  }

  // ---------------------------------------------------------------------------
  // FCM Token
  // ---------------------------------------------------------------------------

  Future<void> _getAndSaveFcmToken() async {
    final token = await _messaging.getToken();
    debugPrint('FCM token: $token');

    if (token != null) {
      await _fcmTokenStorage.saveFcmToken(token);
    }

    _messaging.onTokenRefresh.listen((newToken) async {
      debugPrint('FCM token refreshed: $newToken');
      await _fcmTokenStorage.saveFcmToken(newToken);
    });
  }

  // ---------------------------------------------------------------------------
  // Message listeners
  // ---------------------------------------------------------------------------

  void _setupListeners(GlobalKey<NavigatorState> navigatorKey) {
    // Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('FCM onMessage');

      _refreshNotifications(navigatorKey);

      final context = navigatorKey.currentContext;
      if (context != null && message.notification != null) {
        _showDialog(
          context,
          message.notification!.title,
          message.notification!.body,
        );
      }
    });

    // Background → foreground
    FirebaseMessaging.onMessageOpenedApp.listen((_) {
      debugPrint('FCM onMessageOpenedApp');
      _refreshNotifications(navigatorKey);
    });

    // Terminated
    _messaging.getInitialMessage().then((message) {
      if (message != null) {
        debugPrint('FCM getInitialMessage');
        _refreshNotifications(navigatorKey);
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  void _refreshNotifications(GlobalKey<NavigatorState> navigatorKey) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    try {
      Provider.of<NotificationScreenProvider>(
        context,
        listen: false,
      ).refreshNotifications();
    } catch (e) {
      debugPrint('Provider refresh failed: $e');
    }
  }

  void _showDialog(
      BuildContext context,
      String? title,
      String? body,
      ) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title ?? ''),
        content: Text(body ?? ''),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
