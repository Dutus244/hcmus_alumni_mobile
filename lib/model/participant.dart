import 'package:hcmus_alumni_mobile/model/user.dart';

class Participant {
  final User user;

  Participant(this.user);

  Participant.fromJson(Map<String, dynamic> json) : user = User.fromJson(json);
}
