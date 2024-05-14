class Picture {
  final String id;
  final String pictureUrl;

  Picture(
    this.id,
    this.pictureUrl,
  );

  Picture.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        pictureUrl = json["pictureUrl"];
}
