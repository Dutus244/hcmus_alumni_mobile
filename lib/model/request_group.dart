import 'package:hcmus_alumni_mobile/model/participant.dart';

class RequestGroup {
  final Participant participant;

  RequestGroup(
    this.participant,
  );

  RequestGroup.fromJson(Map<String, dynamic> json)
      : participant = Participant.fromJson(json["user"]);
}
