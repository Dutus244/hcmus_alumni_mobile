import 'package:hcmus_alumni_mobile/model/user.dart';

class Notifications {
  final String id;
  final User creator;
  final String content;
  final String link;
  final String createTime;
  final bool isRead;

  Notifications(this.id, this.creator, this.content, this.link,
      this.createTime, this.isRead);

  Notifications.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        creator = User.fromJson(json["user"]),
        content = json["content"],
        link = json["link"],
        createTime = json["createTime"],
        isRead = json["isRead"];
}
