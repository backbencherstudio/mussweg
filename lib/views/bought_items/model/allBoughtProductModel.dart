class AllBoughtProductModel {
  bool? success;
  String? message;
  List<Data>? data;
  Pagination? pagination;

  AllBoughtProductModel({this.success, this.message, this.data, this.pagination});

  AllBoughtProductModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Data {
  String? orderId;
  String? orderStatus;
  OrderPartner? orderPartner;
  List<Items>? items;

  Data({this.orderId, this.orderStatus, this.orderPartner, this.items});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
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
    final Map<String, dynamic> data = {};
    data['order_id'] = orderId;
    data['order_status'] = orderStatus;
    if (orderPartner != null) {
      data['order_partner'] = orderPartner!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
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
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['avatar'] = avatar;
    return data;
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

    if (json['product_photo'] != null) {
      productPhoto = [];
      for (var v in json['product_photo']) {
        productPhoto!.add(v.toString());
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['quantity'] = quantity;
    data['total_price'] = totalPrice;
    data['product_id'] = productId;
    data['product_title'] = productTitle;
    data['price'] = price;
    data['product_photo'] = productPhoto ?? [];
    return data;
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
    final Map<String, dynamic> data = {};
    data['total'] = total;
    data['page'] = page;
    data['perPage'] = perPage;
    data['totalPages'] = totalPages;
    data['hasNextPage'] = hasNextPage;
    data['hasPrevPage'] = hasPrevPage;
    return data;
  }
}
