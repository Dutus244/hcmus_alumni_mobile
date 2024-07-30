import 'package:hcmus_alumni_mobile/model/inbox_member_response.dart';
import 'package:hcmus_alumni_mobile/model/message.dart';

import 'inbox_member.dart';

class Inbox {
  final int id;
  final String name;
  final bool isGroup;
  final String createAt;
  final String updateAt;
  final List<InboxMember> members;
  final Message latestMessage;
  final bool hasRead;

  Inbox(this.id, this.name, this.isGroup, this.createAt, this.updateAt,
      this.latestMessage, this.members, this.hasRead);

  Inbox.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"] ?? "",
        isGroup = json["isGroup"],
        createAt = json["createAt"],
        updateAt = json["updateAt"],
        members = InboxMemberResponse.fromJson(json).members,
        latestMessage = Message.fromJson(json["latestMessage"]),
        hasRead = json["hasRead"];
}
