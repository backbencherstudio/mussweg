class ClientDashboardDetailsModel {
  final bool success;
  final String message;
  final UserProfileData data;

  ClientDashboardDetailsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ClientDashboardDetailsModel.fromJson(Map<String, dynamic> json) {
    return ClientDashboardDetailsModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data: UserProfileData.fromJson(json["data"]),
    );
  }
}

class UserProfileData {
  final Profile profile;
  final ProductList products;
  final ReviewList reviews;

  UserProfileData({
    required this.profile,
    required this.products,
    required this.reviews,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(
      profile: Profile.fromJson(json["profile"]),
      products: ProductList.fromJson(json["products"]),
      reviews: ReviewList.fromJson(json["reviews"]),
    );
  }
}

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
  final num totalPenalties;

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
      totalPenalties: json["total_penalties"] ?? 0,
    );
  }
}

class ProductList {
  final List<ProductItem> data;
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
      data: (json["data"] as List<dynamic>)
          .map((e) => ProductItem.fromJson(e))
          .toList(),
      total: json["total"] ?? 0,
      currentPage: json["currentPage"] ?? 1,
      perPage: json["perPage"] ?? 10,
      totalPages: json["totalPages"] ?? 1,
    );
  }
}

class ProductItem {
  final String id;
  final String productTitle;
  final String price;
  final List<String> photo;
  final String status;
  final List<String> photoUrls;

  ProductItem({
    required this.id,
    required this.productTitle,
    required this.price,
    required this.photo,
    required this.status,
    required this.photoUrls,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json["id"] ?? "",
      productTitle: json["product_title"] ?? "",
      price: json["price"] ?? "0",
      photo: List<String>.from(json["photo"] ?? []),
      status: json["status"] ?? "",
      photoUrls: List<String>.from(json["photoUrls"] ?? []),
    );
  }
}

class ReviewList {
  final List<ReviewItem> data;
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
      data: (json["data"] as List<dynamic>)
          .map((e) => ReviewItem.fromJson(e))
          .toList(),
      total: json["total"] ?? 0,
      currentPage: json["currentPage"] ?? 1,
      perPage: json["perPage"] ?? 10,
      totalPages: json["totalPages"] ?? 1,
    );
  }
}

class ReviewItem {
  final String id;
  final int rating;
  final String comment;
  final String reviewerName;
  final String reviewerAvatar;
  final String createdAgo;

  ReviewItem({
    required this.id,
    required this.rating,
    required this.comment,
    required this.reviewerName,
    required this.reviewerAvatar,
    required this.createdAgo,
  });

  factory ReviewItem.fromJson(Map<String, dynamic> json) {
    return ReviewItem(
      id: json["id"] ?? "",
      rating: json["rating"] ?? 0,
      comment: json["comment"] ?? "",
      reviewerName: json["reviewer_name"] ?? "",
      reviewerAvatar: json["reviewer_avatar"] ?? "",
      createdAgo: json["created_ago"] ?? "",
    );
  }
}
