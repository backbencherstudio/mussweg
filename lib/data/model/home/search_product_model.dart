class SearchProductModel {
  final bool success;
  final String message;
  final List<Product> data;
  final Pagination pagination;

  SearchProductModel({
    required this.success,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory SearchProductModel.fromJson(Map<String, dynamic> json) {
    return SearchProductModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e))
          .toList() ??
          [],
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
    );
  }
}

class Product {
  final String id;
  final String title;
  final String size;
  final String condition;
  final String createdTime;
  final String? boostTime;
  final String price;
  final List<dynamic>? photo;

  Product({
    required this.id,
    required this.title,
    required this.size,
    required this.condition,
    required this.createdTime,
    this.boostTime,
    required this.price,
    this.photo,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      size: json['size'] ?? '',
      condition: json['condition'] ?? '',
      createdTime: json['created_time'] ?? '',
      boostTime: json['boost_time'],
      price: json['price'] ?? '0',
      photo: json['photo'] ?? [],
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
