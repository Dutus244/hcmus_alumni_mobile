import 'package:hcmus_alumni_mobile/model/user.dart';

class FriendSuggestion {
  final User user;

  FriendSuggestion(
    this.user,
  );

  FriendSuggestion.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json);
}
