class Faculty {
  final int id;
  final String name;

  Faculty(
    this.id,
    this.name,
  );

  Faculty.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}
