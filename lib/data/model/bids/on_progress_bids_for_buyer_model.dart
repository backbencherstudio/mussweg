class OnProgressBidsForBuyerModel {
  final bool success;
  final String message;
  final BidsData data;

  OnProgressBidsForBuyerModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory OnProgressBidsForBuyerModel.fromJson(Map<String, dynamic> json) {
    return OnProgressBidsForBuyerModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: BidsData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class BidsData {
  final List<BidModel> bids;
  final Pagination pagination;

  BidsData({
    required this.bids,
    required this.pagination,
  });

  factory BidsData.fromJson(Map<String, dynamic> json) {
    return BidsData(
      bids: (json['data'] as List<dynamic>? ?? [])
          .map((e) => BidModel.fromJson(e))
          .toList(),
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': bids.map((e) => e.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}

class BidModel {
  final String bidId;
  final String bidAmount;
  final String status;
  final DateTime bidCreatedAt;
  final ProductModel product;

  BidModel({
    required this.bidId,
    required this.bidAmount,
    required this.status,
    required this.bidCreatedAt,
    required this.product,
  });

  factory BidModel.fromJson(Map<String, dynamic> json) {
    return BidModel(
      bidId: json['bid_id'] ?? '',
      bidAmount: json['bid_amount'] ?? '',
      status: json['status'] ?? '',
      bidCreatedAt: DateTime.tryParse(json['bid_created_at'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      product: ProductModel.fromJson(json['product'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bid_id': bidId,
      'bid_amount': bidAmount,
      'status': status,
      'bid_created_at': bidCreatedAt.toIso8601String(),
      'product': product.toJson(),
    };
  }
}

class ProductModel {
  final String id;
  final String productTitle;
  final String originalPrice;
  final String? photo; // nullable because sometimes it's null
  final String size;
  final String condition;

  ProductModel({
    required this.id,
    required this.productTitle,
    required this.originalPrice,
    this.photo,
    required this.size,
    required this.condition,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      productTitle: json['product_title'] ?? '',
      originalPrice: json['original_price'] ?? '',
      photo: json['photo'], // can be null
      size: json['size'] ?? '',
      condition: json['condition'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_title': productTitle,
      'original_price': originalPrice,
      'photo': photo,
      'size': size,
      'condition': condition,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'page': page,
      'perPage': perPage,
      'totalPages': totalPages,
      'hasNextPage': hasNextPage,
      'hasPrevPage': hasPrevPage,
    };
  }
}
