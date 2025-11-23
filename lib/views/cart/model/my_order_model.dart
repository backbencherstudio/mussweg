class MyOrderModel {
  bool? success;
  String? message;
  List<Data>? data;
  Pagination? pagination;

  MyOrderModel({this.success, this.message, this.data, this.pagination});

  MyOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    pagination =
        json['pagination'] != null
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
  Seller? seller;
  String? total;
  String? status;
  String? createdAt;
  List<Items>? items;

  Data({
    this.orderId,
    this.seller,
    this.total,
    this.status,
    this.createdAt,
    this.items,
  });

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    seller =
        json['seller'] != null ? new Seller.fromJson(json['seller']) : null;
    total = json['total'];
    status = json['status'];
    createdAt = json['created_at'];
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
    if (this.seller != null) {
      data['seller'] = this.seller!.toJson();
    }
    data['total'] = this.total;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Seller {
  String? id;
  String? name;
  String? avatar;

  Seller({this.id, this.name, this.avatar});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    return data;
  }
}

class Items {
  String? productId;
  String? title;
  String? price;
  List<String>? photo;
  int? quantity;
  String? totalPrice;

  Items({
    this.productId,
    this.title,
    this.price,
    this.photo,
    this.quantity,
    this.totalPrice,
  });

  Items.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    title = json['title'];
    price = json['price'];
    photo = json['photo'].cast<String>();
    quantity = json['quantity'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['photo'] = this.photo;
    data['quantity'] = this.quantity;
    data['total_price'] = this.totalPrice;
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

  Pagination({
    this.total,
    this.page,
    this.perPage,
    this.totalPages,
    this.hasNextPage,
    this.hasPrevPage,
  });

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
