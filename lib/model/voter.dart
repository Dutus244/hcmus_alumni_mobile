import 'package:hcmus_alumni_mobile/model/user.dart';

class Voter {
  final User user;

  Voter(
    this.user,
  );

  Voter.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json["user"]);
}
