import 'package:hcmus_alumni_mobile/model/faculty.dart';
import 'package:hcmus_alumni_mobile/model/status.dart';
import 'package:hcmus_alumni_mobile/model/tags.dart';
import 'package:hcmus_alumni_mobile/model/tags_response.dart';

import 'creator.dart';

class HallOfFame {
  final String id;
  final String title;
  final String summary;
  final String content;
  final String thumbnail;
  final int beginningYear;
  final int views;
  final String updateAt;
  final String publishedAt;
  final Faculty faculty;
  final Status status;
  final Creator creator;
  final String userId;

  HallOfFame(
    this.id,
    this.title,
    this.summary,
    this.thumbnail,
    this.content,
    this.beginningYear,
    this.views,
    this.updateAt,
    this.publishedAt,
    this.faculty,
    this.status,
    this.creator,
      this.userId,
  );

  HallOfFame.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        summary = json["summary"],
        thumbnail = json["thumbnail"],
        content = json["content"],
        views = json["views"].toInt(),
        beginningYear = json["beginningYear"].toInt(),
        updateAt = json["updateAt"],
        publishedAt = json["publishedAt"],
        faculty = Faculty.fromJson(json["faculty"]),
        status = Status.fromJson(json["status"]),
        creator = Creator.fromJson(json["creator"]),
  userId = json["userId"] ?? "";
}
