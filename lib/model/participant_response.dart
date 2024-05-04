import 'package:hcmus_alumni_mobile/model/participant.dart';

class ParticipantResponse {
  final List<Participant> participant;

  ParticipantResponse(this.participant);

  ParticipantResponse.fromJson(Map<String, dynamic> json)
      : participant = (json["participants"] as List).map((i) => new Participant.fromJson(i)).toList();
}