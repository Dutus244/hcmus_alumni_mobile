import 'package:hcmus_alumni_mobile/model/member.dart';

class MemberResponse {
  final List<Member> member;

  MemberResponse(this.member);

  MemberResponse.fromJson(Map<String, dynamic> json)
      : member = (json["members"] as List)
            .map((i) => new Member.fromJson(i))
            .toList();
}
