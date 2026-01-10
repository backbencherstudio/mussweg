import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/constants/api_end_points.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/socket_service.dart';
import '../../../core/services/token_storage.dart';
import '../../../core/services/user_id_storage.dart';

class LoginScreenProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  final TokenStorage _tokenStorage = TokenStorage();
  final UserIdStorage _userIdStorage = UserIdStorage();

  bool _isObscured = true;
  bool get isObscured => _isObscured;

  void toggleObscured() {
    _isObscured = !_isObscured;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  final ApiService _apiService = ApiService();
  Future<bool> login({
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await _apiService.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password, 'fcm_token': fcmToken},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final token = data['authorization']['access_token'];
        await _tokenStorage.saveToken(token);

        if (data['userid'] != null) {
          await _userIdStorage.saveUserId(data['userid']);
          debugPrint("The authorization token is${data['userid']}");
        } else {
          debugPrint("user Id Not found");
        }

        debugPrint("The authorization token is $token");
        _errorMessage = data['message'];
        _isLoading = false;
        notifyListeners();
        return data['success'];
      } else if (response.statusCode == 401) {
        _isLoading = false;
        _errorMessage = 'Password or email was incorrect';
        notifyListeners();
        return false;
      } else {
        _isLoading = false;
        _errorMessage = 'Login failed: ${response.statusCode}';
        notifyListeners();
        return false;
      }
    } catch (error) {
      _isLoading = false;
      if (error.toString().contains('401')) {
        _errorMessage = 'Password or email was incorrect';
        notifyListeners();
        return false;
      } else {
        _errorMessage = 'Login failed: $error}';
      }
      notifyListeners();
      return false;
    }
  }
}

//   Future<void> logoutUser() async {
//     await _tokenStorage.clearToken();
//     await _userIdStorage.clearUserId();
//     _socketService.disconnect();
//     notifyListeners();
//   }
//
//   Future<void> getMe() async {
//     final getMeUrl = Uri.parse(ApiEndpoints.getMe);
//     try {
//       final token = await _tokenStorage.getToken();
//       final response = await http.get(
//         getMeUrl,
//         headers: {'Authorization': 'Bearer $token'},
//       );
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         debugPrint(" The user data is ${response.body}");
//         final userData = json.decode(response.body);
//         final userId = userData['data']['id'];
//         _user = UserModel.fromJson(userData['data']);
//         debugPrint(" The user name is ${_user?.name ?? 'N/A'}");
//         debugPrint(" The user id is $userId");
//         await _userIdStorage.saveUserId(userId);
//         debugPrint(" The user id is $userId");
//       } else {
//         debugPrint(" Error: ${response.statusCode}");
//       }
//     } catch (e) {
//       debugPrint(" Error: $e");
//     }
//   }
//
// }
