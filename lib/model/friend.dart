import 'package:hcmus_alumni_mobile/model/user.dart';

class Friend {
  final User user;

  Friend(
    this.user,
  );

  Friend.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json["friend"]);
}
