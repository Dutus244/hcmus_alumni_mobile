import 'package:hcmus_alumni_mobile/model/user.dart';

class Message {
  final int id;
  final User sender;
  final String content;
  final String messageType;
  final Message? parentMessage;
  final String createAt;
  final String updateAt;

  Message(this.id, this.content, this.sender, this.messageType,
      this.parentMessage, this.createAt, this.updateAt);

  Message.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        content = json["content"],
        sender = User.fromJson(json["sender"]),
        messageType = json["messageType"],
        parentMessage = json["parentMessage"] != null
            ? Message.fromJson(json["parentMessage"])
            : null,
        createAt = json["createAt"],
        updateAt = json["updateAt"];
}
