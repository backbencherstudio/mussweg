import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/core/services/token_storage.dart';
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

  int currentPage = 1;
  final int perPage = 10;
  bool hasNextPage = false;
  bool isMoreLoading = false;

  Future<void> getChatList() async {
    try {
      _isLoading = true;
      notifyListeners();

      final userId = await _userIdStorage.getUserId();
      final url = Uri.parse(ApiEndpoints.getChatList(userId));
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
    } catch (error) {
      debugPrint("Chat fetch error: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getAllMessage(
    String conversationId, {
    bool isLoadMore = false,
  }) async {
    if (isLoadMore) {
      if (!hasNextPage || isMoreLoading) return;
      isMoreLoading = true;
      notifyListeners();
      currentPage++;
    } else {
      _isLoading = true;
      currentPage = 1;
      notifyListeners();
    }

    try {
      final url = Uri.parse(ApiEndpoints.getAllMessage(conversationId, 1, 100));

      final token = await _tokenStorage.getToken();

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      final decodeData = jsonDecode(response.body);
      final newData = AllMessageModel.fromJson(decodeData);

      // 🔥 Reverse if API returns newest first
      if (newData.data != null) {
        newData.data = newData.data!.reversed.toList();
      }

      if (isLoadMore) {
        _allMessageModel?.data?.insertAll(0, newData.data ?? []);
      } else {
        _allMessageModel = newData;
      }

      // ✅ Correct pagination logic
      hasNextPage = newData.pagination?.hasNextPage ?? false;
    } catch (error) {
      debugPrint("Error loading messages: $error");
    } finally {
      _isLoading = false;
      isMoreLoading = false;
      notifyListeners();
    }
  }

  // ----------------------------
  // Send Message
  // ----------------------------
  Future<void> sendMessage(
    String text,
    String conversationId,
    File? image,
  ) async {
    if (text.trim().isEmpty && image == null) return;

    try {
      final url = Uri.parse(ApiEndpoints.sendMessage);
      final token = await _tokenStorage.getToken();

      var request = http.MultipartRequest("POST", url);
      request.headers['Authorization'] = "Bearer $token";
      request.headers['Accept'] = "application/json";

      request.fields['conversationId'] = conversationId;
      if (text.trim().isNotEmpty) request.fields['text'] = text.trim();

      if (image != null) {
        var file = await http.MultipartFile.fromPath(
          "attachments[]",
          image.path,
        );
        request.files.add(file);
      }
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await getAllMessage(conversationId);
      }
    } catch (error) {
      debugPrint("Send message error: $error");
    }
  }
}
