import 'post.dart';

class PostResponse {
  final List<Post> post;

  PostResponse(this.post);

  PostResponse.fromJson(Map<String, dynamic> json)
      : post = (json["posts"] as List).map((i) => new Post.fromJson(i)).toList();
}
