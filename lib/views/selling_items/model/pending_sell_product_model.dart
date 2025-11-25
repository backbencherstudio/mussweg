// ================= PENDING SELL PRODUCT MODEL =================
class PendingSellProductModel {
  bool? success;
  String? message;
  List<Data>? data;
  Pagination? pagination;

  PendingSellProductModel({this.success, this.message, this.data, this.pagination});

  PendingSellProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

    if (json['data'] != null) {
      data = <Data>[];
      (json['data'] as List).forEach((v) {
        data!.add(Data.fromJson(v as Map<String, dynamic>));
      });
    }

    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    if (data != null) map['data'] = data!.map((v) => v.toJson()).toList();
    if (pagination != null) map['pagination'] = pagination!.toJson();
    return map;
  }
}

// ================= DATA MODEL =================
class Data {
  String? orderId;
  String? orderStatus;
  OrderPartner? orderPartner;
  List<Items>? items;

  Data({this.orderId, this.orderStatus, this.orderPartner, this.items});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id']?.toString();
    orderStatus = json['order_status']?.toString();
    orderPartner = json['order_partner'] != null
        ? OrderPartner.fromJson(json['order_partner'] as Map<String, dynamic>)
        : null;

    if (json['items'] != null) {
      items = <Items>[];
      (json['items'] as List).forEach((v) {
        items!.add(Items.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = orderId;
    map['order_status'] = orderStatus;
    if (orderPartner != null) map['order_partner'] = orderPartner!.toJson();
    if (items != null) map['items'] = items!.map((v) => v.toJson()).toList();
    return map;
  }
}

// ================= ORDER PARTNER MODEL =================
class OrderPartner {
  String? id;
  String? name;
  String? email;
  String? avatar;

  OrderPartner({this.id, this.name, this.email, this.avatar});

  OrderPartner.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    email = json['email']?.toString();
    avatar = json['avatar']?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
    };
  }
}

// ================= ITEMS MODEL =================
class Items {
  int? quantity;
  String? price;
  String? totalPrice;
  String? productId;
  String? productTitle;
  String? productOwnerId;
  List<String>? productPhoto;

  Items({
    this.quantity,
    this.price,
    this.totalPrice,
    this.productId,
    this.productTitle,
    this.productOwnerId,
    this.productPhoto,
  });

  Items.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'] is String
        ? int.tryParse(json['quantity'] ?? '0') ?? 0
        : (json['quantity'] ?? 0);
    price = json['price']?.toString();
    totalPrice = json['total_price']?.toString();
    productId = json['product_id']?.toString();
    productTitle = json['product_title']?.toString();
    productOwnerId = json['product_owner_id']?.toString();

    final photo = json['product_photo'];
    if (photo is List) {
      productPhoto = List<String>.from(photo.map((e) => e.toString()));
    } else if (photo is String) {
      productPhoto = [photo];
    } else if (photo is Map) {
      productPhoto = [photo.toString()];
    } else {
      productPhoto = [];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'price': price,
      'total_price': totalPrice,
      'product_id': productId,
      'product_title': productTitle,
      'product_owner_id': productOwnerId,
      'product_photo': productPhoto,
    };
  }

  /// Helper getter to safely convert price string to double
  double get priceValue => double.tryParse(price ?? '0') ?? 0.0;
}

// ================= PAGINATION MODEL =================
class Pagination {
  int? total;
  int? page;
  int? perPage;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Pagination({this.total, this.page, this.perPage, this.totalPages, this.hasNextPage, this.hasPrevPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'] is String ? int.tryParse(json['total'] ?? '0') : json['total'] ?? 0;
    page = json['page'] is String ? int.tryParse(json['page'] ?? '0') : json['page'] ?? 0;
    perPage = json['perPage'] is String ? int.tryParse(json['perPage'] ?? '0') : json['perPage'] ?? 0;
    totalPages = json['totalPages'] is String ? int.tryParse(json['totalPages'] ?? '0') : json['totalPages'] ?? 0;
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
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
}
