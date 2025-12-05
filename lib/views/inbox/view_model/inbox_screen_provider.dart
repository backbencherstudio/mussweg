import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/core/services/token_storage.dart';
import 'package:mussweg/core/services/user_id_storage.dart';
import 'package:mussweg/views/inbox/model/inbox_model.dart';
import '../model/all_message_model.dart';
import 'package:mussweg/core/services/socket_service.dart';

class InboxScreenProvider extends ChangeNotifier {
  InboxScreenProvider() {
    getChatList();
    initSocket();
  }

  final SocketService socketService = SocketService();
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

  // INIT SOCKET
  Future<void> initSocket() async {
    final token = await _tokenStorage.getToken();

    await socketService.connect(token!);

    socketService.messageStream.listen((data) {
      print(" REAL-TIME MESSAGE RECEIVED → $data");

      try {
        final conversationId = data["data"]["conversationId"];
        getAllMessage(conversationId); // refresh messages
      } catch (e) {
        print("⚠ Error parsing socket message: $e");
      }

      notifyListeners();
    });
  }

  // API FUNCTIONS

  Future<void> createConversation(String participantId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final url = Uri.parse(ApiEndpoints.createConversation);
      final token = await _tokenStorage.getToken();

      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"participant_id": participantId}),
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

  Future<void> getChatList() async {
    try {
      _isLoading = true;
      notifyListeners();

      final url = Uri.parse(ApiEndpoints.getChatList);
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

      if (newData.data != null) {
        newData.data = newData.data!.reversed.toList();
      }

      if (isLoadMore) {
        _allMessageModel?.data?.insertAll(0, newData.data ?? []);
      } else {
        _allMessageModel = newData;
      }

      hasNextPage = newData.pagination?.hasNextPage ?? false;
    } catch (error) {
      debugPrint("Error loading messages: $error");
    } finally {
      _isLoading = false;
      isMoreLoading = false;
      notifyListeners();
    }
  }

  // SEND MESSAGE

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

  @override
  void dispose() {
    socketService.dispose();
    super.dispose();
  }
}
