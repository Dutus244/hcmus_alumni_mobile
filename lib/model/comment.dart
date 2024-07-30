import 'package:hcmus_alumni_mobile/model/permissions.dart';
import 'package:hcmus_alumni_mobile/model/post_v2.dart';
import 'package:hcmus_alumni_mobile/model/user.dart';

class Comment {
  final String id;
  final User creator;
  final String content;
  final int childrenCommentNumber;
  late List<Comment> childrenComments = [];
  final String createAt;
  final String updateAt;
  final Permissions permissions;
  final PostV2? post;

  Comment(this.id, this.creator, this.content, this.childrenCommentNumber,
      this.createAt, this.updateAt, this.permissions, this.post);

  Comment.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        creator = User.fromJson(json["creator"]),
        content = json["content"],
        childrenCommentNumber = json["childrenCommentNumber"].toInt(),
        createAt = json["createAt"],
        updateAt = json["updateAt"],
        permissions = Permissions.fromJson(json["permissions"]),
        post = json["postAdvise"] != null
            ? PostV2.fromJson(json["postAdvise"])
            : null;

  Future<void> fetchChildrenComments(Map<String, dynamic> json) async {
    final newComments =
        (json["comments"] as List).map((i) => Comment.fromJson(i)).toList();
    childrenComments.addAll(newComments);
  }
}
