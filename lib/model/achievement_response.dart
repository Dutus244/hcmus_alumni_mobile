import 'package:hcmus_alumni_mobile/model/achievement.dart';

class AchievementResponse {
  final List<Achievement> achievements;

  AchievementResponse(this.achievements);

  AchievementResponse.fromJson(Map<String, dynamic> json)
      : achievements = (json["achievements"] as List)
      .map((i) => new Achievement.fromJson(i))
      .toList();
}