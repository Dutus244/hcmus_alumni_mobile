import 'package:hcmus_alumni_mobile/model/picture.dart';

class PictureResponse {
  final List<Picture> pictures;

  PictureResponse(this.pictures);

  PictureResponse.fromJson(Map<String, dynamic> json)
      : pictures = (json["pictures"] as List)
            .map((i) => new Picture.fromJson(i))
            .toList();
}
