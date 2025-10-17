
class WishlistModel {
  final bool success;
  final String message;
  final List<WishlistItem> data;

  WishlistModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
    success: json["success"] ?? false,
    message: json["message"] ?? "",
    data: json["data"] == null
        ? []
        : List<WishlistItem>.from(
        json["data"].map((x) => WishlistItem.fromJson(x))),
  );
}

class WishlistItem {
  final String id;
  final String userId;
  final String productId;
  final String productTitle;
  final String? productPhoto;
  final String productSize;
  final String productCondition;
  final String productPrice;
  final int productStock;
  final String createdAt;
  final String? boostTime;

  WishlistItem({
    required this.id,
    required this.userId,
    required this.productId,
    required this.productTitle,
    this.productPhoto,
    required this.productSize,
    required this.productCondition,
    required this.productPrice,
    required this.productStock,
    required this.createdAt,
    this.boostTime,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) => WishlistItem(
    id: json["id"] ?? "",
    userId: json["user_id"] ?? "",
    productId: json["product_id"] ?? "",
    productTitle: json["product_title"] ?? "",
    productPhoto: json["product_photo"],
    productSize: json["product_size"] ?? "",
    productCondition: json["product_condition"] ?? "",
    productPrice: json["product_price"] ?? "0",
    productStock: json["product_stock"] ?? 0,
    createdAt: json["created_at"] ?? "",
    boostTime: json["boost_time"],
  );

}
