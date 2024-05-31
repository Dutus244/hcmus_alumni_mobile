import 'hall_of_fame.dart';

class HallOfFameResponse {
  final List<HallOfFame> hallOfFames;

  HallOfFameResponse(this.hallOfFames);

  HallOfFameResponse.fromJson(Map<String, dynamic> json)
      : hallOfFames = (json["hof"] as List)
            .map((i) => new HallOfFame.fromJson(i))
            .toList();
}
