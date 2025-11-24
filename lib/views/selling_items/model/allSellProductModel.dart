class AllSellProductModel {
  bool? success;
  String? message;
  List<Data>? data;
  Pagination? pagination;

  AllSellProductModel({this.success, this.message, this.data, this.pagination});

  AllSellProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
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
    orderPartner = json['order_partner'] != null
        ? new OrderPartner.fromJson(json['order_partner'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_status'] = this.orderStatus;
    if (this.orderPartner != null) {
      data['order_partner'] = this.orderPartner!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
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
    id = json['id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    return data;
  }
}

class Items {
  int? quantity;
  String? totalPrice;
  String? productId;
  String? productTitle;
  String? price;
  String? productOwnerId;
  List<String>? productPhoto;

  Items(
      {this.quantity,
        this.totalPrice,
        this.productId,
        this.productTitle,
        this.price,
        this.productOwnerId,
        this.productPhoto});

  Items.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    totalPrice = json['total_price'];
    productId = json['product_id'];
    productTitle = json['product_title'];
    price = json['price'];
    productOwnerId = json['product_owner_id'];
    productPhoto = json['product_photo'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['total_price'] = this.totalPrice;
    data['product_id'] = this.productId;
    data['product_title'] = this.productTitle;
    data['price'] = this.price;
    data['product_owner_id'] = this.productOwnerId;
    data['product_photo'] = this.productPhoto;
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

  Pagination(
      {this.total,
        this.page,
        this.perPage,
        this.totalPages,
        this.hasNextPage,
        this.hasPrevPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    perPage = json['perPage'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page'] = this.page;
    data['perPage'] = this.perPage;
    data['totalPages'] = this.totalPages;
    data['hasNextPage'] = this.hasNextPage;
    data['hasPrevPage'] = this.hasPrevPage;
    return data;
  }
}
