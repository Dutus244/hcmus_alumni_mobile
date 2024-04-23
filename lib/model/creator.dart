class Creator {
  final String fullName;

  Creator(
    this.fullName,
  );

  Creator.fromJson(Map<String, dynamic> json) : fullName = json["fullName"];
}
