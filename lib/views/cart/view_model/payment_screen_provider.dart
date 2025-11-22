import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/core/services/token_storage.dart';
import 'package:mussweg/views/cart/model/cart_model.dart';

class PaymentScreenProvider extends ChangeNotifier {
  final TokenStorage _tokenStorage = TokenStorage();

  CartModel? _cartModel;
  CartModel? get cartModel => _cartModel;

  //  CREATE CART
  Future<void> createCart(String productId) async {
    try {
      final url = Uri.parse(ApiEndpoints.createCart);
      final token = await _tokenStorage.getToken();

      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"product_id": productId}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Cart created successfully");
      } else {
        print("Create Cart Failed: ${response.statusCode}");
      }
    } catch (error) {
      print("Create Cart Error: $error");
    }
  }

  //  GET MY CART
  Future<void> getMyCart() async {
    debugPrint("----------------------------  fetch ------------------");
    try {
      final url = Uri.parse(ApiEndpoints.getMyCart);
      final token = await _tokenStorage.getToken();

      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = jsonDecode(response.body);
        _cartModel = CartModel.fromJson(decodedData);

        notifyListeners(); // update UI
        debugPrint("Cart Fetched");
      } else {
        debugPrint("Get Cart Failed: ${response.statusCode}");
      }
    } catch (error) {
      debugPrint("Get Cart Error: $error");
    }
  }

  // UPDATE CART
  Future<void> updateCart(String cartItemId, String quantity) async {
    try {
      final url = Uri.parse(ApiEndpoints.updateCart(cartItemId));
      final token = await _tokenStorage.getToken();

      final response = await http.patch(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"quantity": quantity}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Cart Updated");
        await getMyCart(); // refresh cart model
      } else {
        print("Update Cart Failed: ${response.statusCode}");
      }
    } catch (error) {
      print("Update Cart Error: $error");
    }
  }
}
