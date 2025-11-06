class BidsResponse {
  final bool success;
  final String message;
  final Product? product;
  final List<Bid> bids;

  BidsResponse({
    required this.success,
    required this.message,
    required this.product,
    required this.bids,
  });

  factory BidsResponse.fromJson(Map<String, dynamic> json) {
    return BidsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      product: json['product'] != null
          ? Product.fromJson(json['product'])
          : null,
      bids: json['bids'] != null
          ? List<Bid>.from(json['bids'].map((x) => Bid.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'product': product?.toJson(),
      'bids': bids.map((x) => x.toJson()).toList(),
    };
  }
}

class Product {
  final String id;
  final String productTitle;
  final String location;
  final String price;
  final String? photo;
  final String condition;
  final String size;
  final String? boostUntil;

  Product({
    required this.id,
    required this.productTitle,
    required this.location,
    required this.price,
    this.photo,
    required this.condition,
    required this.size,
    this.boostUntil,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      productTitle: json['product_title'] ?? '',
      location: json['location'] ?? '',
      price: json['price'] ?? '',
      photo: json['photo'],
      condition: json['condition'] ?? '',
      size: json['size'] ?? '',
      boostUntil: json['boost_until'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_title': productTitle,
      'location': location,
      'price': price,
      'photo': photo,
      'condition': condition,
      'size': size,
      'boost_until': boostUntil,
    };
  }
}

class Bid {
  final String id;
  final String bidAmount;
  final String status;
  final String biderId;
  final String biderName;
  final String biderAvatar;

  Bid({
    required this.id,
    required this.bidAmount,
    required this.status,
    required this.biderId,
    required this.biderName,
    required this.biderAvatar,
  });

  factory Bid.fromJson(Map<String, dynamic> json) {
    return Bid(
      id: json['id'] ?? '',
      bidAmount: json['bid_amount'] ?? '',
      status: json['status'] ?? '',
      biderId: json['bider_id'] ?? '',
      biderName: json['bider_name'] ?? '',
      biderAvatar: json['bider_avatar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bid_amount': bidAmount,
      'status': status,
      'bider_id': biderId,
      'bider_name': biderName,
      'bider_avatar': biderAvatar,
    };
  }
}
