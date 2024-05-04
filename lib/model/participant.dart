class Participant {
  final String id;
  final String fullName;
  final String avatarUrl;

  Participant(this.id, this.fullName, this.avatarUrl);

  Participant.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        fullName = json["fullName"],
        avatarUrl = json["avatarUrl"];
}
