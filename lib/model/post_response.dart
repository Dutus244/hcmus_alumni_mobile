import 'post.dart';

class PostResponse {
  final List<Post> posts;

  PostResponse(this.posts);

  PostResponse.fromJson(Map<String, dynamic> json)
      : posts =
            (json["posts"] as List).map((i) => new Post.fromJson(i)).toList();
}
