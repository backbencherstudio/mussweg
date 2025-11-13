class RequestBidForSellerResponseModel {
  final bool success;
  final String message;
  final ProductsData data;

  RequestBidForSellerResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RequestBidForSellerResponseModel.fromJson(Map<String, dynamic> json) {
    return RequestBidForSellerResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ProductsData.fromJson(json['data']),
    );
  }
}

class ProductsData {
  final List<ProductWithBids> data;
  final Pagination pagination;

  ProductsData({
    required this.data,
    required this.pagination,
  });

  factory ProductsData.fromJson(Map<String, dynamic> json) {
    return ProductsData(
      data: json['data'] != null
          ? List<ProductWithBids>.from(
          json['data'].map((x) => ProductWithBids.fromJson(x)))
          : [],
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class ProductWithBids {
  final Product product;
  final List<Bid> bids;

  ProductWithBids({
    required this.product,
    required this.bids,
  });

  factory ProductWithBids.fromJson(Map<String, dynamic> json) {
    return ProductWithBids(
      product: Product.fromJson(json['product']),
      bids: json['bids'] != null
          ? List<Bid>.from(json['bids'].map((x) => Bid.fromJson(x)))
          : [],
    );
  }
}

class Product {
  final String id;
  final String title;
  final String price;
  final String photo;
  final String size;
  final String? boostUntil;
  final String condition;
  final String createdAt;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.photo,
    required this.size,
    this.boostUntil,
    required this.condition,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      price: json['price'] ?? '',
      photo: json['photo'] ?? '',
      size: json['size'] ?? '',
      boostUntil: json['boost_until'],
      condition: json['condition'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}

class Bid {
  final String bidId;
  final String amount;
  final String status;
  final Bidder bidder;
  final String bidTime;

  Bid({
    required this.bidId,
    required this.amount,
    required this.status,
    required this.bidder,
    required this.bidTime,
  });

  factory Bid.fromJson(Map<String, dynamic> json) {
    return Bid(
      bidId: json['bid_id'] ?? '',
      amount: json['amount'] ?? '',
      status: json['status'] ?? '',
      bidder: Bidder.fromJson(json['bidder']),
      bidTime: json['bid_time'] ?? '',
    );
  }
}

class Bidder {
  final String id;
  final String name;
  final String avatar;

  Bidder({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory Bidder.fromJson(Map<String, dynamic> json) {
    return Bidder(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }
}

class Pagination {
  final int total;
  final int page;
  final int perPage;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPrevPage;

  Pagination({
    required this.total,
    required this.page,
    required this.perPage,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      perPage: json['perPage'] ?? 10,
      totalPages: json['totalPages'] ?? 1,
      hasNextPage: json['hasNextPage'] ?? false,
      hasPrevPage: json['hasPrevPage'] ?? false,
    );
  }
}
