class Creator {
  final String? id;
  final String fullName;
  final String? avatarUrl;

  Creator(this.id, this.fullName, this.avatarUrl);

  Creator.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        fullName = json["fullName"],
        avatarUrl = json["avatarUrl"];
}
