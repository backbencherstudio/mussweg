class WishListModel {
  final bool success;
  final String message;
  final List<WishlistItem> data;
  final Pagination pagination;

  WishListModel({
    required this.success,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory WishListModel.fromJson(Map<String, dynamic> json) {
    return WishListModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((item) => WishlistItem.fromJson(item))
              .toList() ??
          [],
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
    );
  }
}

class WishlistItem {
  final String id;
  final String userId;
  final String productId;
  final String productTitle;
  final List<String>? productPhoto;
  final String productSize;
  final String productCondition;
  final String productPrice;
  final int productStock;
  final String createdAt;
  final String? boostTime;

  // Translated fields
  String? translatedTitle;
  String? translatedSize;
  String? translatedCondition;

  WishlistItem({
    required this.id,
    required this.userId,
    required this.productId,
    required this.productTitle,
    this.productPhoto,
    required this.productSize,
    required this.productCondition,
    required this.productPrice,
    required this.productStock,
    required this.createdAt,
    this.boostTime,
    this.translatedTitle,
    this.translatedSize,
    this.translatedCondition,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      productId: json['product_id'] ?? '',
      productTitle: json['product_title'] ?? '',
      productPhoto:
          json['product_photo'] != null
              ? List<String>.from(json['product_photo'])
              : null,
      productSize: json['product_size'] ?? '',
      productCondition: json['product_condition'] ?? '',
      productPrice: json['product_price'] ?? '',
      productStock: json['product_stock'] ?? 0,
      createdAt: json['created_at'] ?? '',
      boostTime: json['boost_time'],
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
      perPage: json['perPage'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      hasNextPage: json['hasNextPage'] ?? false,
      hasPrevPage: json['hasPrevPage'] ?? false,
    );
  }
}
