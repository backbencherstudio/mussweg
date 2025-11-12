class PendingBoughtProductModel {
  bool? success;
  String? message;
  List<Data>? data;
  Pagination? pagination;

  PendingBoughtProductModel({this.success, this.message, this.data, this.pagination});

  PendingBoughtProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination!.toJson();
    }
    return map;
  }
}

class Data {
  String? orderId;
  String? orderStatus;
  OrderPartner? orderPartner;
  List<Items>? items;

  Data({this.orderId, this.orderStatus, this.orderPartner, this.items});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id']?.toString();
    orderStatus = json['order_status'];
    orderPartner = json['order_partner'] != null ? OrderPartner.fromJson(json['order_partner']) : null;

    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['order_id'] = orderId;
    map['order_status'] = orderStatus;
    if (orderPartner != null) {
      map['order_partner'] = orderPartner!.toJson();
    }
    if (items != null) {
      map['items'] = items!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class OrderPartner {
  String? id;
  String? name;
  String? email;
  String? avatar;

  OrderPartner({this.id, this.name, this.email, this.avatar});

  OrderPartner.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['avatar'] = avatar;
    return map;
  }
}

class Items {
  int? quantity;
  double? totalPrice;
  String? productId;
  String? productTitle;
  double? price;
  List<String>? productPhoto;

  Items({this.quantity, this.totalPrice, this.productId, this.productTitle, this.price, this.productPhoto});

  Items.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    totalPrice = json['total_price'] != null ? double.tryParse(json['total_price'].toString()) : null;
    productId = json['product_id']?.toString();
    productTitle = json['product_title'];
    price = json['price'] != null ? double.tryParse(json['price'].toString()) : null;

    if (json['product_photo'] != null && json['product_photo'] is List) {
      productPhoto = List<String>.from(json['product_photo'].map((x) => x.toString()));
    } else {
      productPhoto = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['quantity'] = quantity;
    map['total_price'] = totalPrice;
    map['product_id'] = productId;
    map['product_title'] = productTitle;
    map['price'] = price;
    map['product_photo'] = productPhoto ?? [];
    return map;
  }
}

class Pagination {
  int? total;
  int? page;
  int? perPage;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Pagination({this.total, this.page, this.perPage, this.totalPages, this.hasNextPage, this.hasPrevPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    perPage = json['perPage'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['total'] = total;
    map['page'] = page;
    map['perPage'] = perPage;
    map['totalPages'] = totalPages;
    map['hasNextPage'] = hasNextPage;
    map['hasPrevPage'] = hasPrevPage;
    return map;
  }
}
