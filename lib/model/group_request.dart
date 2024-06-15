import 'package:hcmus_alumni_mobile/model/user.dart';

class GroupRequest {
  final User user;

  GroupRequest(
    this.user,
  );

  GroupRequest.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json["user"]);
}
