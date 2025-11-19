import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/core/services/token_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mussweg/core/services/user_id_storage.dart';
import 'package:mussweg/views/inbox/model/inbox_model.dart';

import '../model/all_message_model.dart';

class InboxScreenProvider extends ChangeNotifier {
  InboxScreenProvider() {
    getChatList();
  }

  final TokenStorage _tokenStorage = TokenStorage();
  final UserIdStorage _userIdStorage = UserIdStorage();

  InboxModel? _inboxModel;
  InboxModel? get inboxModel => _inboxModel;

  AllMessageModel? _allMessageModel;
  AllMessageModel? get allMessageModel => _allMessageModel;

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
      _inboxModel = InboxModel.fromJson(decodeData);

      debugPrint("Chat list loaded: ${decodeData['message']}");
    } catch (error) {
      debugPrint("Chat fetch error: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getAllMessage(String conversationId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final url = Uri.parse(ApiEndpoints.getAllMessage(conversationId));

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
      _allMessageModel = AllMessageModel.fromJson(decodeData);

      debugPrint("Chat message all loaded: ${decodeData['message']}");
    } catch (error) {
      debugPrint("Chat fetch error: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendMessage(
      String text,
      String conversationId,
      File? image,
      ) async {
    if (text.trim().isEmpty && image == null) return;

    try {
      _isLoading = true;
      notifyListeners();

      final url = Uri.parse(ApiEndpoints.sendMessage);
      final token = await _tokenStorage.getToken();

      var request = http.MultipartRequest("POST", url);
      request.headers['Authorization'] = "Bearer $token";
      request.headers['Accept'] = "application/json";

      request.fields['conversationId'] = conversationId;
      if (text.trim().isNotEmpty) {
        request.fields['text'] = text.trim();
      }

      if (image != null) {
        var file = await http.MultipartFile.fromPath("attachments[]", image.path);
        request.files.add(file);
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final decodeData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Message sent successfully: ${decodeData['message']}");
      } else {
        debugPrint("Send message failed: ${response.statusCode} - ${decodeData['message']}");
        // Optionally show error to user
      }
    } catch (error) {
      debugPrint("Send message error: $error");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
