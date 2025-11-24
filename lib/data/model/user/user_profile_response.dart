class UserProfileResponse {
  final bool success;
  final UserProfileData data;

  UserProfileResponse({
    required this.success,
    required this.data,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      success: json['success'] ?? false,
      data: UserProfileData.fromJson(json['data'] ?? {}),
    );
  }
}

class UserProfileData {
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
  final double? rating;
  final String? reviewCount;
  final String? totalEarning;
  final String? totalPenalties;

  UserProfileData({
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
    this.rating,
    this.reviewCount,
    this.totalEarning,
    this.totalPenalties,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'],
      coverPhoto: json['cover_photo'],
      country: json['country'],
      city: json['city'],
      address: json['address'],
      avatarUrl: json['avatar_url'],
      coverPhotoUrl: json['cover_photo_url'],
      location: json['location'],
      rating: json['rating'] != null ? double.tryParse(json['rating'].toString()) : null,
      reviewCount: (json["review_count"] ?? '0').toString(),  // Ensure it's a String
      totalEarning: (json["total_earning"] ?? "0").toString(),  // Ensure it's a String
      totalPenalties: (json["total_penalties"] ?? 0).toString(),
    );
  }
}
