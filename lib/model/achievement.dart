class Achievement {
  final int id;
  final String name;
  final String type;
  final String time;

  Achievement(this.id, this.name, this.type, this.time);

  Achievement.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        type = json["type"],
        time = json["time"];
}