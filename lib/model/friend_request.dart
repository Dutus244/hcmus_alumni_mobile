import 'package:hcmus_alumni_mobile/model/user.dart';

class FriendRequest {
  final User user;

  FriendRequest(
      this.user,
      );

  FriendRequest.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json["user"]);
}