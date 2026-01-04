// lib/data/user_all_products/user_all_products_viewmodel.dart

class UserAllProductsViewmodel {
  final List<ProductData> data;
  final Pagination pagination;

  UserAllProductsViewmodel({
    required this.data,
    required this.pagination,
  });

  /// Handles BOTH List and Map responses safely
  factory UserAllProductsViewmodel.fromJson(dynamic json) {
    // CASE 1: API returns List directly
    if (json is List) {
      return UserAllProductsViewmodel(
        data: json
            .map((e) => ProductData.fromJson(e as Map<String, dynamic>))
            .toList(),
        pagination: Pagination.empty(),
      );
    }

    // CASE 2: API returns Map with data + pagination
    if (json is Map<String, dynamic>) {
      final dataList = json['data'];

      return UserAllProductsViewmodel(
        data: (dataList is List
            ? dataList
            : dataList?['products'] ?? [])
            .map<ProductData>(
                (e) => ProductData.fromJson(e as Map<String, dynamic>))
            .toList(),
        pagination: json['pagination'] != null
            ? Pagination.fromJson(json['pagination'])
            : Pagination.empty(),
      );
    }

    throw Exception('Invalid API response');
  }
}


class ProductData {
  final String id;
  final List<String>? photo; // filenames only
  final List<String>? productPhotoUrl; // full URLs
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

  // Translated fields
  String? translatedTitle;
  String? translatedDescription;
  String? translatedLocation;
  String? translatedCondition;
  String? translatedSize;
  String? translatedColor;

  ProductData({
    required this.id,
    required this.photo,
    required this.productPhotoUrl,
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
    this.translatedTitle,
    this.translatedDescription,
    this.translatedLocation,
    this.translatedCondition,
    this.translatedSize,
    this.translatedColor,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'] ?? '',
      photo:
          (json['photo'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      productPhotoUrl:
          (json['product_photo_url'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
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
      'product_photo_url': productPhotoUrl,
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
      'translatedTitle': translatedTitle,
      'translatedDescription': translatedDescription,
      'translatedLocation': translatedLocation,
      'translatedCondition': translatedCondition,
      'translatedSize': translatedSize,
      'translatedColor': translatedColor,
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
