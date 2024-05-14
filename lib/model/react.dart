class React {
  final int id;
  final String name;

  React(
      this.id,
      this.name,
      );

  React.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}