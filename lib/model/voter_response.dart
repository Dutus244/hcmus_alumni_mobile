import 'package:hcmus_alumni_mobile/model/voter.dart';

class VoterResponse {
  final List<Voter> voters;

  VoterResponse(this.voters);

  VoterResponse.fromJson(Map<String, dynamic> json)
      : voters =
            (json["users"] as List).map((i) => new Voter.fromJson(i)).toList();
}
