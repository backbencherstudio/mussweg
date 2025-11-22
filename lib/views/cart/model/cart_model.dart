class CartModel {
  bool? success;
  String? message;
  Data? data;

  CartModel({this.success, this.message, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  List<Items>? items;
  double? grandTotal;

  Data({this.items, this.grandTotal});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    grandTotal =
        json['grand_total'] != null
            ? double.tryParse(json['grand_total'].toString())
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (items != null) data['items'] = items!.map((v) => v.toJson()).toList();
    data['grand_total'] = grandTotal;
    return data;
  }
}

class Items {
  String? cartItemId;
  String? productId;
  String? productTitle;
  double? price;
  int? quantity;
  double? totalPrice;
  String? size;
  String? condition;
  String? photo;

  Items({
    this.cartItemId,
    this.productId,
    this.productTitle,
    this.price,
    this.quantity,
    this.totalPrice,
    this.size,
    this.condition,
    this.photo,
  });

  Items.fromJson(Map<String, dynamic> json) {
    cartItemId = json['cart_item_id'];
    productId = json['product_id'];
    productTitle = json['product_title'];
    price =
        json['price'] != null
            ? double.tryParse(json['price'].toString())
            : null;
    quantity =
        json['quantity'] != null
            ? int.tryParse(json['quantity'].toString())
            : null;
    totalPrice =
        json['total_price'] != null
            ? double.tryParse(json['total_price'].toString())
            : null;
    size = json['size'];
    condition = json['condition'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['cart_item_id'] = cartItemId;
    data['product_id'] = productId;
    data['product_title'] = productTitle;
    data['price'] = price;
    data['quantity'] = quantity;
    data['total_price'] = totalPrice;
    data['size'] = size;
    data['condition'] = condition;
    data['photo'] = photo;
    return data;
  }
}
