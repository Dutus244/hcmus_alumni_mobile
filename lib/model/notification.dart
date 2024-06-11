import 'package:hcmus_alumni_mobile/model/participant.dart';

class Notifications {
  final String id;
  final Participant participant;
  final String content;
  final String link;
  final String createTime;

  Notifications(this.id, this.participant, this.content, this.link, this.createTime);

  Notifications.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        participant = Participant.fromJson(json["user"]),
        content = json["content"],
        link = json["link"],
        createTime = json["createTime"];
}