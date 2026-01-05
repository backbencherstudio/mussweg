class BoostDataModel {
  bool? success;
  String? message;
  List<Data>? data;
  Pagination? pagination;

  BoostDataModel({this.success, this.message, this.data, this.pagination});

  BoostDataModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? title;
  String? price;
  String? condition;
  String? size;
  String? createdTime;
  List<String>? photo;
  String? boostStartTime;
  String? boostEndTime;
  String? boostUntilTime;
  String? boostStatus;
  String? boostPaymentStatus;

  Data(
      {this.id,
        this.title,
        this.price,
        this.condition,
        this.size,
        this.createdTime,
        this.photo,
        this.boostStartTime,
        this.boostEndTime,
        this.boostUntilTime,
        this.boostStatus,
        this.boostPaymentStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    condition = json['condition'];
    size = json['size'];
    createdTime = json['created_time'];
    photo = json['photo'].cast<String>();
    boostStartTime = json['boost_start_time'];
    boostEndTime = json['boost_end_time'];
    boostUntilTime = json['boost_until_time'];
    boostStatus = json['boost_status'];
    boostPaymentStatus = json['boost_payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['condition'] = this.condition;
    data['size'] = this.size;
    data['created_time'] = this.createdTime;
    data['photo'] = this.photo;
    data['boost_start_time'] = this.boostStartTime;
    data['boost_end_time'] = this.boostEndTime;
    data['boost_until_time'] = this.boostUntilTime;
    data['boost_status'] = this.boostStatus;
    data['boost_payment_status'] = this.boostPaymentStatus;
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
