class AcceptedBidForSellerResponseModel {
  final bool success;
  final String message;
  final AcceptedBidsData data;

  AcceptedBidForSellerResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AcceptedBidForSellerResponseModel.fromJson(Map<String, dynamic> json) {
    return AcceptedBidForSellerResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: AcceptedBidsData.fromJson(json['data']),
    );
  }
}

class AcceptedBidsData {
  final List<BidItem> data;
  final Pagination pagination;

  AcceptedBidsData({
    required this.data,
    required this.pagination,
  });

  factory AcceptedBidsData.fromJson(Map<String, dynamic> json) {
    return AcceptedBidsData(
      data: json['data'] != null
          ? List<BidItem>.from(json['data'].map((x) => BidItem.fromJson(x)))
          : [],
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class BidItem {
  final String bidId;
  final String bidAmount;
  final String status;
  final String bidCreatedAt;
  final Product product;
  final Bidder bidder;

  BidItem({
    required this.bidId,
    required this.bidAmount,
    required this.status,
    required this.bidCreatedAt,
    required this.product,
    required this.bidder,
  });

  factory BidItem.fromJson(Map<String, dynamic> json) {
    return BidItem(
      bidId: json['bid_id'] ?? '',
      bidAmount: json['bid_amount'] ?? '',
      status: json['status'] ?? '',
      bidCreatedAt: json['bid_created_at'] ?? '',
      product: Product.fromJson(json['product']),
      bidder: Bidder.fromJson(json['bidder']),
    );
  }
}

class Product {
  final String id;
  final String title;
  final String price;
  final String photo;
  final String size;
  final String condition;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.photo,
    required this.size,
    required this.condition,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      price: json['price'] ?? '',
      photo: json['photo'] ?? '',
      size: json['size'] ?? '',
      condition: json['condition'] ?? '',
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
