class BoostProductResponse {
  final bool success;
  final String message;
  final BoostedProductData? data;

  BoostProductResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory BoostProductResponse.fromJson(Map<String, dynamic> json) {
    return BoostProductResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? BoostedProductData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class BoostedProductData {
  final String id;
  final String photo;
  final String title;
  final String size;
  final String condition;
  final DateTime createdTime;
  final DateTime boostTime;
  final String price;

  BoostedProductData({
    required this.id,
    required this.photo,
    required this.title,
    required this.size,
    required this.condition,
    required this.createdTime,
    required this.boostTime,
    required this.price,
  });

  factory BoostedProductData.fromJson(Map<String, dynamic> json) {
    return BoostedProductData(
      id: json['id'] ?? '',
      photo: json['photo'] ?? '',
      title: json['title'] ?? '',
      size: json['size'] ?? '',
      condition: json['condition'] ?? '',
      createdTime: DateTime.tryParse(json['created_time'] ?? '') ?? DateTime.now(),
      boostTime: DateTime.tryParse(json['boost_time'] ?? '') ?? DateTime.now(),
      price: json['price']?.toString() ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photo': photo,
      'title': title,
      'size': size,
      'condition': condition,
      'created_time': createdTime.toIso8601String(),
      'boost_time': boostTime.toIso8601String(),
      'price': price,
    };
  }
}
