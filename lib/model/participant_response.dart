import 'package:hcmus_alumni_mobile/model/participant.dart';

class ParticipantResponse {
  final List<Participant> participants;

  ParticipantResponse(this.participants);

  ParticipantResponse.fromJson(Map<String, dynamic> json)
      : participants = (json["participants"] as List)
            .map((i) => new Participant.fromJson(i))
            .toList();
}
