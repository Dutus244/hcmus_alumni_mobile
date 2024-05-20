import 'dart:ui';

import 'package:hcmus_alumni_mobile/model/faculty.dart';
import 'package:hcmus_alumni_mobile/model/permissions.dart';
import 'package:hcmus_alumni_mobile/model/picture.dart';
import 'package:hcmus_alumni_mobile/model/picture_response.dart';
import 'package:hcmus_alumni_mobile/model/status.dart';
import 'package:hcmus_alumni_mobile/model/tags.dart';
import 'package:hcmus_alumni_mobile/model/tags_response.dart';

import 'creator.dart';

class Post {
  final String id;
  final String title;
  final String content;
  final int childrenCommentNumber;
  final String updateAt;
  final String publishedAt;
  final List<Tags> tags;
  final Status status;
  final Creator creator;
  final List<Picture> picture;
  late bool isReacted;
  late int reactionCount;
  final Permissions permissions;

  Post(
      this.id,
      this.title,
      this.content,
      this.childrenCommentNumber,
      this.updateAt,
      this.publishedAt,
      this.tags,
      this.status,
      this.creator,
      this.picture,
      this.isReacted,
      this.reactionCount,
      this.permissions);

  Post.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        content = json["content"],
        childrenCommentNumber = json["childrenCommentNumber"].toInt(),
        updateAt = json["updateAt"],
        publishedAt = json["publishedAt"],
        tags = TagsResponse.fromJson(json).tags,
        status = Status.fromJson(json["status"]),
        creator = Creator.fromJson(json["creator"]),
        picture = PictureResponse.fromJson(json).picture,
        isReacted = json["isReacted"],
        reactionCount = json["reactionCount"].toInt(),
        permissions = Permissions.fromJson(json['permissions']);
}
