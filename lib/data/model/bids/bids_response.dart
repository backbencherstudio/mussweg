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
}

class Product {
  final String id;
  final String productTitle;
  final String location;
  final String price;
  final List<String>? photo;
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
      photo: json['photo'] != null
          ? List<String>.from(json['photo'].map((x) => x.toString()))
          : [],
      condition: json['condition'] ?? '',
      size: json['size'] ?? '',
      boostUntil: json['boost_until'],
    );
  }
}

class Bid {
  final String id;
  final String bidAmount;
  final String status;
  final String lastUpdated;
  final String biderId;
  final String biderName;
  final String biderAvatar;

  Bid({
    required this.id,
    required this.bidAmount,
    required this.status,
    required this.lastUpdated,
    required this.biderId,
    required this.biderName,
    required this.biderAvatar,
  });

  factory Bid.fromJson(Map<String, dynamic> json) {
    return Bid(
      id: json['id'] ?? '',
      bidAmount: json['bid_amount'] ?? '',
      status: json['status'] ?? '',
      lastUpdated: json['last_updated'] ?? '',
      biderId: json['bider_id'] ?? '',
      biderName: json['bider_name'] ?? '',
      biderAvatar: json['bider_avatar'] ?? '',
    );
  }
}
