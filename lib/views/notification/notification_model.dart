class NotificationModel {
  bool? success;
  List<Data>? data;

  NotificationModel({this.success, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Null? readAt;
  int? status;
  String? senderId;
  String? receiverId;
  String? notificationEventId;
  Null? entityId;

  Data(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.readAt,
        this.status,
        this.senderId,
        this.receiverId,
        this.notificationEventId,
        this.entityId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    readAt = json['read_at'];
    status = json['status'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    notificationEventId = json['notification_event_id'];
    entityId = json['entity_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['read_at'] = this.readAt;
    data['status'] = this.status;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['notification_event_id'] = this.notificationEventId;
    data['entity_id'] = this.entityId;
    return data;
  }
}
