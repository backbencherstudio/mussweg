class CategoryBasedProductModel {
  final bool success;
  final String message;
  final List<ProductData> data;
  final Pagination pagination;

  CategoryBasedProductModel({
    required this.success,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory CategoryBasedProductModel.fromJson(Map<String, dynamic> json) {
    return CategoryBasedProductModel(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => ProductData.fromJson(item))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}

class ProductData {
  final String id;
  final String? photo;
  final String title;
  final String size;
  final String condition;
  final String createdTime;
  final String? boostTimeLeft;
  final String price;
  final bool isInWishlist;
  final String? minimumBid;

  ProductData({
    required this.id,
    this.photo,
    required this.title,
    required this.size,
    required this.condition,
    required this.createdTime,
    this.boostTimeLeft,
    required this.price,
    required this.isInWishlist,
    this.minimumBid,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'],
      photo: json['photo'],
      title: json['title'],
      size: json['size'],
      condition: json['condition'],
      createdTime: json['created_time'],
      boostTimeLeft: json['boost_time_left'],
      price: json['price'],
      isInWishlist: json['is_in_wishlist'],
      minimumBid: json['minimum_bid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photo': photo,
      'title': title,
      'size': size,
      'condition': condition,
      'created_time': createdTime,
      'boost_time_left': boostTimeLeft,
      'price': price,
      'is_in_wishlist': isInWishlist,
      'minimum_bid': minimumBid,
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
      total: json['total'],
      page: json['page'],
      perPage: json['perPage'],
      totalPages: json['totalPages'],
      hasNextPage: json['hasNextPage'],
      hasPrevPage: json['hasPrevPage'],
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
