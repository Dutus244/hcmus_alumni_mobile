import 'package:hcmus_alumni_mobile/model/picture.dart';

class PictureResponse {
  final List<Picture> picture;

  PictureResponse(this.picture);

  PictureResponse.fromJson(Map<String, dynamic> json)
      : picture = (json["pictures"] as List)
            .map((i) => new Picture.fromJson(i))
            .toList();
}
