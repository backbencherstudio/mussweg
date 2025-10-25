class UserAllProductsViewmodel {
  final bool success;
  final String message;
  final List<ProductData> data;
  final Pagination pagination;

  UserAllProductsViewmodel({
    required this.success,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory UserAllProductsViewmodel.fromJson(Map<String, dynamic> json) {
    return UserAllProductsViewmodel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => ProductData.fromJson(item))
          .toList() ??
          [],
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : Pagination.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}

class ProductData {
  final String id;
  final String? photo;
  final String title;
  final String price;
  final String description;
  final String location;
  final String condition;
  final String size;
  final String color;
  final String uploaded;
  final String? remainingTime;
  final bool isInWishlist;

  ProductData({
    required this.id,
    this.photo,
    required this.title,
    required this.price,
    required this.description,
    required this.location,
    required this.condition,
    required this.size,
    required this.color,
    required this.uploaded,
    this.remainingTime,
    required this.isInWishlist,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'] ?? '',
      photo: json['photo'],
      title: json['title'] ?? '',
      price: json['price']?.toString() ?? '0',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      condition: json['condition'] ?? '',
      size: json['size'] ?? '',
      color: json['color'] ?? '',
      uploaded: json['uploaded'] ?? '',
      remainingTime: json['remaining_time'],
      isInWishlist: json['is_in_wishlist'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photo': photo,
      'title': title,
      'price': price,
      'description': description,
      'location': location,
      'condition': condition,
      'size': size,
      'color': color,
      'uploaded': uploaded,
      'remaining_time': remainingTime,
      'is_in_wishlist': isInWishlist,
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

  /// helper constructor for fallback
  factory Pagination.empty() {
    return Pagination(
      total: 0,
      page: 1,
      perPage: 10,
      totalPages: 1,
      hasNextPage: false,
      hasPrevPage: false,
    );
  }
}
