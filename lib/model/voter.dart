import 'package:hcmus_alumni_mobile/model/participant.dart';

class Voter {
  final Participant participant;

  Voter(
    this.participant,
  );

  Voter.fromJson(Map<String, dynamic> json)
      : participant = Participant.fromJson(json["user"]);
}
