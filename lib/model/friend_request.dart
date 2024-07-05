import 'package:hcmus_alumni_mobile/model/user.dart';

class FriendRequest {
  final User user;
  final String createAt;

  FriendRequest(
    this.user,
    this.createAt,
  );

  FriendRequest.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json["friend"]),
        createAt = json["createAt"];
}
