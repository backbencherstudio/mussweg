class InboxModel {
  String? message;
  bool? success;
  List<Conversations>? conversations;

  InboxModel({this.message, this.success, this.conversations});

  InboxModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    if (json['conversations'] != null) {
      conversations = <Conversations>[];
      json['conversations'].forEach((v) {
        conversations!.add(new Conversations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    if (this.conversations != null) {
      data['conversations'] =
          this.conversations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Conversations {
  String? id;
  List<Participants>? participants;
  LastMessage? lastMessage;

  Conversations({this.id, this.participants, this.lastMessage});

  Conversations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(new Participants.fromJson(v));
      });
    }
    lastMessage = json['lastMessage'] != null
        ? new LastMessage.fromJson(json['lastMessage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    if (this.lastMessage != null) {
      data['lastMessage'] = this.lastMessage!.toJson();
    }
    return data;
  }
}

class Participants {
  String? userId;
  String? name;
  String? avatar;

  Participants({this.userId, this.name, this.avatar});

  Participants.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    return data;
  }
}

class LastMessage {
  String? text;
  String? attachments;
  String? createdAt;

  LastMessage({this.text, this.attachments, this.createdAt});

  LastMessage.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    attachments = json['attachments'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['attachments'] = this.attachments;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
