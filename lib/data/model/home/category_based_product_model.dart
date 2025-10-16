class CategoryBasedProductModel {
  final bool success;
  final String message;
  final CategoryData data;

  CategoryBasedProductModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CategoryBasedProductModel.fromJson(Map<String, dynamic> json) {
    return CategoryBasedProductModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: CategoryData.fromJson(json['data'] ?? {}),
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

class CategoryData {
  final List<Product> products;
  final int productCount;

  CategoryData({
    required this.products,
    required this.productCount,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List? ?? [];
    return CategoryData(
      products: productList.map((e) => Product.fromJson(e)).toList(),
      productCount: json['product_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((e) => e.toJson()).toList(),
      'product_count': productCount,
    };
  }
}

class Product {
  final String id;
  final String? photo;
  final String title;
  final String size;
  final String condition;
  final String createdTime;
  final String? boostTimeLeft;
  final String price;
  final bool isInWishlist;

  Product({
    required this.id,
    this.photo,
    required this.title,
    required this.size,
    required this.condition,
    required this.createdTime,
    this.boostTimeLeft,
    required this.price,
    required this.isInWishlist,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      photo: json['photo'],
      title: json['title'] ?? '',
      size: json['size'] ?? '',
      condition: json['condition'] ?? '',
      createdTime: json['created_time'] ?? '',
      boostTimeLeft: json['boost_time_left'],
      price: json['price'] ?? '',
      isInWishlist: json['is_in_wishlist'] ?? false,
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
    };
  }
}
