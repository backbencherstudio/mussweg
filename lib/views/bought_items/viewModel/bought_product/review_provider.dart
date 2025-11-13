import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/core/services/token_storage.dart';

class ReviewProvider extends ChangeNotifier {
  final TokenStorage _tokenStorage = TokenStorage();
  String? _message;
  String? get message => _message;

  Future<void> reviewCreate({
    required String ownerId,
    required double rating,
    required String comment,
    required String orderId,
  }) async {
    final url = Uri.parse(ApiEndpoints.createReview);

    debugPrint(
      "========== $ownerId  ---- $comment ------- $rating -------- $orderId",
    );
    try {
      final token = await _tokenStorage.getToken();

      final reviewData = {
        "order_id": orderId,
        "rating": rating,
        "comment": comment,
        "review_receiver": ownerId,
      };

      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(reviewData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodeData = jsonDecode(response.body);
        debugPrint(" Review created successfully");
        _message = "${decodeData['message']['message']}";
        notifyListeners();
      } else {
        final decodeData = jsonDecode(response.body);

        debugPrint("Failed to create review: ${response.statusCode}");
        _message = "${decodeData['message']['message']}";

        debugPrint("Response body: ${response.body}");
      }
    } catch (error) {
      debugPrint(" The error message is $error");
    }
  }
}
