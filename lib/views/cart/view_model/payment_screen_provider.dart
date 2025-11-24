import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mussweg/core/constants/api_end_points.dart';
import 'package:mussweg/core/services/token_storage.dart';
import 'package:mussweg/views/cart/model/cart_model.dart';

import '../model/my_order_model.dart' hide Items;

class PaymentScreenProvider extends ChangeNotifier {
  String selectedOrderId = "";
  int selectedIndex = -1;
  selectOrder(String orderId, int index) {
    selectedOrderId = orderId;
    selectedIndex = index;

    debugPrint("The selected index $orderId $index");
    notifyListeners();
  }

  final TokenStorage _tokenStorage = TokenStorage();
  MyOrderModel? _myOrderModel;
  MyOrderModel? get myOrderModel => _myOrderModel;
  CartModel? _cartModel;
  CartModel? get cartModel => _cartModel;
  List<Items> selectedCartItems = [];

  void toggleCartItemSelection(Items item, bool isSelected) {
    if (isSelected) {
      selectedCartItems.add(item);
    } else {
      selectedCartItems.removeWhere((e) => e.cartItemId == item.cartItemId);
    }
    notifyListeners();
  }

  void clearSelectedItems() {
    selectedCartItems.clear();
    notifyListeners();
  }

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
        debugPrint("Cart created successfully");
      } else {
        debugPrint("Create Cart Failed: ${response.statusCode}");
      }
    } catch (error) {
      debugPrint("Create Cart Error: $error");
    }
  }

  Future<void> getMyCart() async {
    try {
      final url = Uri.parse(ApiEndpoints.getMyCart);
      final token = await _tokenStorage.getToken();

      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer $token"},
      );
      if (response.statusCode == 200) {
        _cartModel = CartModel.fromJson(jsonDecode(response.body));
        notifyListeners();
      } else {
        debugPrint("Get Cart Failed: ${response.statusCode}");
      }
    } catch (error) {
      debugPrint("Get Cart Error: $error");
    }
  }

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
        await getMyCart();
      } else {
        debugPrint("Update Cart Failed: ${response.statusCode}");
      }
    } catch (error) {
      debugPrint("Update Cart Error: $error");
    }
  }

  Future<void> createOrder(Map<String, dynamic> shippingData) async {
    try {
      final token = await _tokenStorage.getToken();
      final url = Uri.parse(ApiEndpoints.orderCreate);

      final cartItemIds = selectedCartItems.map((e) => e.cartItemId).toList();

      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"cartItemIds": cartItemIds, ...shippingData}),
      );

      final decodedData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Order Success: ${decodedData['message']}");
      } else {
        debugPrint("Order Failed: ${decodedData['message']}");
      }
    } catch (error) {
      debugPrint("Create Order Error: $error");
    }
  }

  Future<void> getMyOrder() async {
    try {
      final token = await _tokenStorage.getToken();
      final url = Uri.parse(ApiEndpoints.myOrderList);

      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer $token"},
      );

      final decodeData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _myOrderModel = MyOrderModel.fromJson(decodeData);

        debugPrint("THe success message ${decodeData['message']}");
      } else {
        debugPrint("THe failed message ${decodeData['message']}");
      }
    } catch (error) {
      debugPrint("THe failed message $error");
    }
  }

  Future<String> stripPay() async {
    try {
      final token = await _tokenStorage.getToken();
      final url = Uri.parse(ApiEndpoints.stripPayment(selectedOrderId));

      final response = await http.post(
        url,
        headers: {"Authorization": "Bearer $token"},
      );

      final decodeData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Stripe success message ${decodeData['message']}");
        debugPrint("Stripe success message ${response.body}");
        debugPrint("Stripe success message ${decodeData}");
        return decodeData['clientSecret'];
      } else {
        debugPrint("Stripe failed message ${decodeData['message']}");
        throw Exception(decodeData['message']);
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
