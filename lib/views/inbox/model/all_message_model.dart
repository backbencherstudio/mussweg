class AllMessageModel {
  String? message;
  bool? success;
  List<Data>? data;
  Pagination? pagination;

  AllMessageModel({this.message, this.success, this.data, this.pagination});

  AllMessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
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
    data['message'] = this.message;
    data['success'] = this.success;
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
  String? text;
  List<String>? attachments;
  String? createdAt;
  Sender? sender;

  Data({this.id, this.text, this.attachments, this.createdAt, this.sender});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    attachments = json['attachments'].cast<String>();
    createdAt = json['createdAt'];
    sender =
    json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['attachments'] = this.attachments;
    data['createdAt'] = this.createdAt;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    return data;
  }
}

class Sender {
  String? id;
  String? name;
  String? email;
  String? avater;
  String? avatarUrl;

  Sender({this.id, this.name, this.email, this.avater, this.avatarUrl});

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    avater = json['avater'];
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['avater'] = this.avater;
    data['avatar_url'] = this.avatarUrl;
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
