class PostV2 {
  final String id;
  final String title;

  PostV2(
      this.id,
      this.title,
      );

  PostV2.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"];
}