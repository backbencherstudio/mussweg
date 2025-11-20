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
        data!.add(Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    data['success'] = success;
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
  String? id;
  String? text;
  List<String>? attachments;
  List<String>? attachmentsUrl;
  String? createdAt;
  Sender? sender;
  Sender? receiver;

  Data({
    this.id,
    this.text,
    this.attachments,
    this.attachmentsUrl,
    this.createdAt,
    this.sender,
    this.receiver,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    attachments = json['attachments'] != null
        ? List<String>.from(json['attachments'])
        : null;
    attachmentsUrl = json['attachments_url'] != null
        ? List<String>.from(json['attachments_url'])
        : null;
    createdAt = json['createdAt'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    receiver =
    json['receiver'] != null ? Sender.fromJson(json['receiver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['text'] = text;
    if (attachments != null) data['attachments'] = attachments;
    if (attachmentsUrl != null) data['attachments_url'] = attachmentsUrl;
    data['createdAt'] = createdAt;
    if (sender != null) data['sender'] = sender!.toJson();
    if (receiver != null) data['receiver'] = receiver!.toJson();
    return data;
  }
}

class Sender {
  String? id;
  String? name;
  String? email;
  String? avater;      // <-- corrected type
  String? avatarUrl;   // <-- corrected type

  Sender({this.id, this.name, this.email, this.avater, this.avatarUrl});

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    avater = json['avater'];
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['avater'] = avater;
    data['avatar_url'] = avatarUrl;
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
