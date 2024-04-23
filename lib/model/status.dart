class Status {
  final String name;

  Status(
    this.name,
  );

  Status.fromJson(Map<String, dynamic> json) : name = json["name"];
}
