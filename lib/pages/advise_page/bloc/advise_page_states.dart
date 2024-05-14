import 'package:hcmus_alumni_mobile/model/post.dart';

enum Status { loading, success }

class AdvisePageState {
  final Status statusPost;
  final List<Post> post;
  final int indexPost;
  final bool hasReachedMaxPost;

  AdvisePageState({
    this.statusPost = Status.loading,
    this.post = const [],
    this.indexPost = 0,
    this.hasReachedMaxPost = false,
  });

  AdvisePageState copyWith({
    Status? statusPost,
    List<Post>? post,
    int? indexPost,
    bool? hasReachedMaxPost,
  }) {
    return AdvisePageState(
        statusPost: statusPost ?? this.statusPost,
        post: post ?? this.post,
        indexPost: indexPost ?? this.indexPost,
        hasReachedMaxPost: hasReachedMaxPost ?? this.hasReachedMaxPost);
  }
}