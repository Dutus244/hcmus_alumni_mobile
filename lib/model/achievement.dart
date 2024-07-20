import 'package:intl/intl.dart';

class Achievement {
  final String id;
  final String name;
  final String type;
  final String time;

  Achievement(this.id, this.name, this.type, this.time);

  Achievement.fromJson(Map<String, dynamic> json)
      : id = json["achievementId"],
        name = json["achievementName"],
        type = json["achievementType"],
        time = json["achievementTime"] != null ? DateFormat('MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(json["achievementTime"]).add(Duration(days: 1))) : '';
}
