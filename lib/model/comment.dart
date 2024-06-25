import 'package:hcmus_alumni_mobile/model/permissions.dart';
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

  Comment(this.id, this.creator, this.content, this.childrenCommentNumber,
      this.createAt, this.updateAt, this.permissions);

  Comment.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        creator = User.fromJson(json["creator"]),
        content = json["content"],
        childrenCommentNumber = json["childrenCommentNumber"].toInt(),
        createAt = json["createAt"],
        updateAt = json["updateAt"],
        permissions = Permissions.fromJson(json["permissions"]);

  Future<void> fetchChildrenComments(Map<String, dynamic> json) async {
    childrenComments =
        (json["comments"] as List).map((i) => new Comment.fromJson(i)).toList();
  }
}
