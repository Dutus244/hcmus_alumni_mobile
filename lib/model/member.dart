import 'package:hcmus_alumni_mobile/model/user.dart';

class Member {
  final User user;
  final String role;

  Member(
    this.user,
    this.role,
  );

  Member.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json["user"]),
        role = json["role"];
}
