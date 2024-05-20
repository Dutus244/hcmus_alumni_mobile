import 'package:hcmus_alumni_mobile/model/participant.dart';

class Member {
  final Participant participant;
  final String role;

  Member(
    this.participant,
    this.role,
  );

  Member.fromJson(Map<String, dynamic> json)
      : participant = Participant.fromJson(json["user"]),
        role = json["role"];
}
