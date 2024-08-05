import 'package:hcmus_alumni_mobile/model/faculty.dart';
import 'package:hcmus_alumni_mobile/model/status.dart';
import 'package:hcmus_alumni_mobile/model/tags.dart';
import 'package:hcmus_alumni_mobile/model/tags_response.dart';
import 'package:hcmus_alumni_mobile/model/user.dart';

class News {
  final String id;
  final String title;
  final String summary;
  final String content;
  final String thumbnail;
  final int views;
  late int childrenCommentNumber;
  final String updateAt;
  final String publishedAt;
  final List<Tags> tags;
  final Faculty faculty;
  final Status status;
  final User creator;

  News(
    this.id,
    this.title,
    this.summary,
    this.thumbnail,
    this.content,
    this.views,
    this.childrenCommentNumber,
    this.updateAt,
    this.publishedAt,
    this.tags,
    this.faculty,
    this.status,
    this.creator,
  );

  News.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        summary = json["summary"],
        thumbnail = json["thumbnail"],
        content = json["content"] != null ? json["content"] : "",
        views = json["views"].toInt(),
        childrenCommentNumber = json["childrenCommentNumber"].toInt(),
        updateAt = json["updateAt"],
        publishedAt = json["publishedAt"],
        tags = TagsResponse.fromJson(json).tags,
        faculty = Faculty.fromJson(json["faculty"]),
        status = Status.fromJson(json["status"]),
        creator = User.fromJson(json["creator"]);
}
