import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/core/services/token_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mussweg/core/services/user_id_storage.dart';
import 'package:mussweg/views/inbox/model/inbox_model.dart';

class InboxScreenProvider extends ChangeNotifier {
  InboxScreenProvider() {
    getChatList();
  }

  final TokenStorage _tokenStorage = TokenStorage();
  final UserIdStorage _userIdStorage = UserIdStorage();

  InboxModel? _inboxModel;
  InboxModel? get inboxModel => _inboxModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getChatList() async {
    try {
      _isLoading = true;
      notifyListeners();

      final userId = await _userIdStorage.getUserId();
      final url = Uri.parse(ApiEndpoints.getChatList(userId));

      debugPrint("URL: $url");

      final token = await _tokenStorage.getToken();

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      final decodeData = jsonDecode(response.body);

      // Always decode safely
      _inboxModel = InboxModel.fromJson(decodeData);

      debugPrint("Chat list loaded: ${decodeData['message']}");
    } catch (error) {
      debugPrint("Chat fetch error: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
