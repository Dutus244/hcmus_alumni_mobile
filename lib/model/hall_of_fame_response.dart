import 'hall_of_fame.dart';

class HallOfFameResponse {
  final List<HallOfFame> hallOfFame;

  HallOfFameResponse(this.hallOfFame);

  HallOfFameResponse.fromJson(Map<String, dynamic> json)
      : hallOfFame = (json["hof"] as List)
            .map((i) => new HallOfFame.fromJson(i))
            .toList();
}
