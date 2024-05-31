import 'package:hcmus_alumni_mobile/model/comment.dart';

class CommentResponse {
  final List<Comment> comments;

  CommentResponse(this.comments);

  CommentResponse.fromJson(Map<String, dynamic> json)
      : comments = (json["comments"] as List)
            .map((i) => new Comment.fromJson(i))
            .toList();
}
