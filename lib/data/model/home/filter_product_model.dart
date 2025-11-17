class FilterProductModel {
  final bool success;
  final String message;
  final ProductsData data;

  FilterProductModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FilterProductModel.fromJson(Map<String, dynamic> json) {
    return FilterProductModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ProductsData.fromJson(json['data'] ?? {}),
    );
  }
}

class ProductsData {
  final List<Product> products;
  final int productCount;

  ProductsData({
    required this.products,
    required this.productCount,
  });

  factory ProductsData.fromJson(Map<String, dynamic> json) {
    return ProductsData(
      products: (json['products'] as List<dynamic>? ?? [])
          .map((e) => Product.fromJson(e))
          .toList(),
      productCount: json['product_count'] ?? 0,
    );
  }
}

class Product {
  final String id;
  final List<String>? photo;
  final String title;
  final String status;
  final String size;
  final String condition;
  final String createdTime;
  final String? boostTime;
  final String price;
  final bool isInWishlist;

  Product({
    required this.id,
    this.photo,
    required this.title,
    required this.status,
    required this.size,
    required this.condition,
    required this.createdTime,
    this.boostTime,
    required this.price,
    required this.isInWishlist,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      photo: (json['photo'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      title: json['title'] ?? '',
      status: json['status'] ?? '',
      size: json['size'] ?? '',
      condition: json['condition'] ?? '',
      createdTime: json['created_time'] ?? '',
      boostTime: json['boost_time'],
      price: json['price'] ?? '',
      isInWishlist: json['is_in_wishlist'] ?? false,
    );
  }
}
