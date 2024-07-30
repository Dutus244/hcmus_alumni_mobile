class Permissions {
  final bool edit;
  final bool delete;

  Permissions(
    this.edit,
    this.delete,
  );

  Permissions.fromJson(Map<String, dynamic> json)
      : edit = json["edit"],
        delete = json["delete"];
}
