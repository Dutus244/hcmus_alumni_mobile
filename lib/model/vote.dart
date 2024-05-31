class Vote {
  final int id;
  final String name;
  final int voteCount;
  final bool isVoted;

  Vote(this.id, this.name, this.voteCount, this.isVoted);

  Vote.fromJson(Map<String, dynamic> json)
      : id = json["id"]["voteId"],
        name = json["name"],
        voteCount = json["voteCount"].toInt(),
        isVoted = json["isVoted"];
}
