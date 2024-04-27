import 'package:hcmus_alumni_mobile/model/comment.dart';

class CommentResponse {
  final List<Comment> comment;

  CommentResponse(this.comment);

  CommentResponse.fromJson(Map<String, dynamic> json)
      : comment = (json["comments"] as List)
            .map((i) => new Comment.fromJson(i))
            .toList();
}
