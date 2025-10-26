class ProductDetailsResponse {
  final bool? success;
  final String? message;
  final ProductData? data;

  ProductDetailsResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailsResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? ProductData.fromJson(json['data']) : null,
    );
  }
}

class ProductData {
  final SellerInfo? sellerInfo;
  final String? productId;
  final String? productPhoto;
  final String? title;
  final String? status;
  final String? location;
  final String? price;
  final String? description;
  final String? condition;
  final String? size;
  final String? productItemSize;
  final String? color;
  final String? uploaded;
  final String? remainingTime;
  final String? minimumBid;
  final Category? category;

  ProductData({
    this.sellerInfo,
    this.productId,
    this.productPhoto,
    this.title,
    this.status,
    this.location,
    this.price,
    this.description,
    this.condition,
    this.size,
    this.productItemSize,
    this.color,
    this.uploaded,
    this.remainingTime,
    this.minimumBid,
    this.category,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      sellerInfo: json['seller_Info'] != null
          ? SellerInfo.fromJson(json['seller_Info'])
          : null,
      productId: json['product_id'],
      productPhoto: json['product_photo'],
      title: json['title'],
      status: json['status'],
      location: json['location'],
      price: json['price'],
      description: json['description'],
      condition: json['condition'],
      size: json['size'],
      productItemSize: json['product_item_size'],
      color: json['color'],
      uploaded: json['uploaded'],
      remainingTime: json['remaining_time'],
      minimumBid: json['minimum_bid'],
      category:
      json['category'] != null ? Category.fromJson(json['category']) : null,
    );
  }
}

class SellerInfo {
  final String? userId;
  final String? name;
  final String? profilePhoto;
  final int? totalItems;

  SellerInfo({
    this.userId,
    this.name,
    this.profilePhoto,
    this.totalItems,
  });

  factory SellerInfo.fromJson(Map<String, dynamic> json) {
    return SellerInfo(
      userId: json['user_id'],
      name: json['name'],
      profilePhoto: json['profile_photo'],
      totalItems: json['total_items'],
    );
  }
}

class Category {
  final String? id;
  final String? categoryName;

  Category({
    this.id,
    this.categoryName,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      categoryName: json['category_name'],
    );
  }
}
