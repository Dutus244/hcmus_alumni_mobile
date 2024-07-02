class Sex {
  final int id;
  final String name;

  Sex(
    this.id,
    this.name,
  );

  Sex.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}
