class Tags {
  final int id;
  final String name;

  Tags(
    this.id,
    this.name,
  );

  Tags.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}
