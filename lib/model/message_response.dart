import 'package:hcmus_alumni_mobile/model/message.dart';

class MessageResponse {
  final List<Message> messages;

  MessageResponse(this.messages);

  MessageResponse.fromJson(Map<String, dynamic> json)
      : messages = (json["messages"] as List).map((i) => new Message.fromJson(i)).toList();
}