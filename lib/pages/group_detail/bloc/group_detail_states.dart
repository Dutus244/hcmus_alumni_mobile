import '../../../model/group.dart';
import '../../../model/post.dart';

enum Status { loading, success }

class GroupDetailState {
  final Group? group;
  final Status statusPost;
  final List<Post> post;
  final int indexPost;
  final bool hasReachedMaxPost;

  GroupDetailState(
      {this.group = null,
      this.statusPost = Status.loading,
      this.post = const [],
      this.indexPost = 0,
      this.hasReachedMaxPost = false});

  GroupDetailState copyWith({
    Group? group,
    Status? statusPost,
    List<Post>? post,
    int? indexPost,
    bool? hasReachedMaxPost,
  }) {
    return GroupDetailState(
        group: group ?? this.group,
        statusPost: statusPost ?? this.statusPost,
        post: post ?? this.post,
        indexPost: indexPost ?? this.indexPost,
        hasReachedMaxPost: hasReachedMaxPost ?? this.hasReachedMaxPost);
  }
}
