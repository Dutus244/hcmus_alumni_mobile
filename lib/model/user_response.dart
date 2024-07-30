import 'package:hcmus_alumni_mobile/model/user.dart';

class UserResponse {
  final List<User> users;

  UserResponse(this.users);

  UserResponse.fromJson(Map<String, dynamic> json)
      : users = (json["users"] as List).map((i) => new User.fromJson(i)).toList();
}