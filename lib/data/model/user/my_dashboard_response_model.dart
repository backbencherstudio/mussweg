class MyDashboardResponseModel {
  final bool success;
  final String message;
  final DashboardData data;

  MyDashboardResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory MyDashboardResponseModel.fromJson(Map<String, dynamic> json) {
    return MyDashboardResponseModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data: DashboardData.fromJson(json["data"] ?? {}),
    );
  }
}

// ------------------ MAIN DATA ------------------

class DashboardData {
  final Profile profile;
  final ProductList products;
  final ReviewList reviews;

  DashboardData({
    required this.profile,
    required this.products,
    required this.reviews,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      profile: Profile.fromJson(json["profile"] ?? {}),
      products: ProductList.fromJson(json["products"] ?? {}),
      reviews: ReviewList.fromJson(json["reviews"] ?? {}),
    );
  }
}

// ------------------ PROFILE ------------------

class Profile {
  final String id;
  final String name;
  final String? avatar;
  final String? coverPhoto;
  final String? country;
  final String? city;
  final String? address;
  final String? avatarUrl;
  final String? coverPhotoUrl;
  final String? location;
  final double rating;
  final int reviewCount;
  final String totalEarning;
  final String totalPenalties;

  Profile({
    required this.id,
    required this.name,
    this.avatar,
    this.coverPhoto,
    this.country,
    this.city,
    this.address,
    this.avatarUrl,
    this.coverPhotoUrl,
    this.location,
    required this.rating,
    required this.reviewCount,
    required this.totalEarning,
    required this.totalPenalties,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      avatar: json["avatar"],
      coverPhoto: json["cover_photo"],
      country: json["country"],
      city: json["city"],
      address: json["address"],
      avatarUrl: json["avatarUrl"],
      coverPhotoUrl: json["coverPhotoUrl"],
      location: json["location"],
      rating: (json["rating"] ?? 0).toDouble(),
      reviewCount: json["review_count"] ?? 0,
      totalEarning: json["total_earning"] ?? "0",
      totalPenalties: json["total_penalties"] ?? "0",
    );
  }
}

// ------------------ PRODUCT LIST ------------------

class ProductList {
  final List<ProductData> data;
  final int total;
  final int currentPage;
  final int perPage;
  final int totalPages;

  ProductList({
    required this.data,
    required this.total,
    required this.currentPage,
    required this.perPage,
    required this.totalPages,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) {
    return ProductList(
      data: (json["data"] as List<dynamic>? ?? [])
          .map((e) => ProductData.fromJson(e))
          .toList(),
      total: json["total"] ?? 0,
      currentPage: json["currentPage"] ?? 1,
      perPage: json["perPage"] ?? 10,
      totalPages: json["totalPages"] ?? 1,
    );
  }
}

// ------------------ SINGLE PRODUCT ------------------

class ProductData {
  final String id;
  final String productTitle;
  final String price;
  final List<String> photo;
  final String status;
  final List<String> photoUrls;

  ProductData({
    required this.id,
    required this.productTitle,
    required this.price,
    required this.photo,
    required this.status,
    required this.photoUrls,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json["id"] ?? "",
      productTitle: json["product_title"] ?? "",
      price: json["price"] ?? "0",
      photo:
      (json["photo"] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
      status: json["status"] ?? "",
      photoUrls:
      (json["photoUrls"] as List<dynamic>? ?? []).map((e) => e.toString()).toList(),
    );
  }
}

// ------------------ REVIEW LIST ------------------

class ReviewList {
  final List<ReviewData> data;
  final int total;
  final int currentPage;
  final int perPage;
  final int totalPages;

  ReviewList({
    required this.data,
    required this.total,
    required this.currentPage,
    required this.perPage,
    required this.totalPages,
  });

  factory ReviewList.fromJson(Map<String, dynamic> json) {
    return ReviewList(
      data: (json["data"] as List<dynamic>? ?? [])
          .map((e) => ReviewData.fromJson(e))
          .toList(),
      total: json["total"] ?? 0,
      currentPage: json["currentPage"] ?? 1,
      perPage: json["perPage"] ?? 10,
      totalPages: json["totalPages"] ?? 1,
    );
  }
}

// ------------------ SINGLE REVIEW ------------------

class ReviewData {
  final String id;
  final int rating;
  final String comment;
  final String reviewerName;
  final String? reviewerAvatar;
  final String createdAgo;

  ReviewData({
    required this.id,
    required this.rating,
    required this.comment,
    required this.reviewerName,
    this.reviewerAvatar,
    required this.createdAgo,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
      id: json["id"] ?? "",
      rating: json["rating"] ?? 0,
      comment: json["comment"] ?? "",
      reviewerName: json["reviewer_name"] ?? "",
      reviewerAvatar: json["reviewer_avatar"],
      createdAgo: json["created_ago"] ?? "",
    );
  }
}
