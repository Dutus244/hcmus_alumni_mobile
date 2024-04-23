import 'package:hcmus_alumni_mobile/model/tags.dart';

class TagsResponse {
  final List<Tags> tags;

  TagsResponse(this.tags);

  TagsResponse.fromJson(Map<String, dynamic> json)
      : tags = (json["tags"] as List).map((i) => new Tags.fromJson(i)).toList();
}
