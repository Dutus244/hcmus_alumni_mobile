import 'package:hcmus_alumni_mobile/model/inbox_member.dart';

class InboxMemberResponse {
  final List<InboxMember> members;

  InboxMemberResponse(this.members);

  InboxMemberResponse.fromJson(Map<String, dynamic> json)
      : members = (json["members"] as List)
      .map((i) => new InboxMember.fromJson(i))
      .toList();
}