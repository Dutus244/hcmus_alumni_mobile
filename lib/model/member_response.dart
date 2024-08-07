import 'package:hcmus_alumni_mobile/model/member.dart';

class MemberResponse {
  final List<Member> members;

  MemberResponse(this.members);

  MemberResponse.fromJson(Map<String, dynamic> json)
      : members = (json["members"] as List)
            .map((i) => new Member.fromJson(i))
            .toList();
}
