import 'package:hcmus_alumni_mobile/model/user.dart';

class InboxMember {
  final int inboxId;
  final String userId;
  final User user;
  final String joinedAt;

  InboxMember(this.inboxId, this.userId, this.user, this.joinedAt);

  InboxMember.fromJson(Map<String, dynamic> json)
      : inboxId = json["id"]["inboxId"],
        userId = json["id"]["userId"],
        user = User.fromJson(json["user"]),
        joinedAt = json["joinedAt"];
}
