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
  Opponent? opponent;
  LastMessage? lastMessage;

  Conversations({this.id, this.opponent, this.lastMessage});

  Conversations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    opponent = json['opponent'] != null
        ? new Opponent.fromJson(json['opponent'])
        : null;
    lastMessage = json['lastMessage'] != null
        ? new LastMessage.fromJson(json['lastMessage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.opponent != null) {
      data['opponent'] = this.opponent!.toJson();
    }
    if (this.lastMessage != null) {
      data['lastMessage'] = this.lastMessage!.toJson();
    }
    return data;
  }
}

class Opponent {
  String? userId;
  String? name;
  String? avater;
  String? avatarUrl;

  Opponent({this.userId, this.name, this.avater, this.avatarUrl});

  Opponent.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    avater = json['avater'];
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['avater'] = this.avater;
    data['avatar_url'] = this.avatarUrl;
    return data;
  }
}

class LastMessage {
  String? text;
  String? createdAt;

  LastMessage({this.text, this.createdAt});

  LastMessage.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
