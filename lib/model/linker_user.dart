class LinkerUser {
  final String id;
  final String fullName;
  final String email;

  LinkerUser(this.id, this.fullName, this.email);

  LinkerUser.fromJson(Map<String, dynamic> json)
      : fullName = json["fullName"],
        id = json["id"],
        email = json["email"];
}
