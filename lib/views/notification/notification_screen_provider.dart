import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../core/constants/api_end_points.dart';
import '../../../core/services/token_storage.dart';
import 'package:http/http.dart' as http;

import 'notification_model.dart';

class NotificationScreenProvider extends ChangeNotifier {
  final TokenStorage _tokenStorage = TokenStorage();
  NotificationModel? _notificationModel;
  NotificationModel? get notificationModel => _notificationModel;

  Future<void> refreshNotifications() async {
    await getNotification();
    notifyListeners();
  }

  Future<void> getNotification() async {
    try {
      final token = await _tokenStorage.getToken();
      final url = Uri.parse(ApiEndpoints.notification);

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body);
        _notificationModel = NotificationModel.fromJson(decoded);
        debugPrint(
          'Admin notifications fetched: ${_notificationModel?.data?.length ?? 0}',
        );
      } else {
        debugPrint(
          'Failed to fetch notifications: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      debugPrint('Error fetching admin notifications: $e');
    }
  }
}
