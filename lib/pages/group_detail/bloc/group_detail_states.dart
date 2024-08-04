import '../../../model/group.dart';
import '../../../model/post.dart';

enum Status { loading, success }

class GroupDetailState {
  final Group? group;
  final Status statusPost;
  final List<Post> posts;
  final int indexPost;
  final bool hasReachedMaxPost;
  final bool isLoading;

  GroupDetailState(
      {this.group = null,
      this.statusPost = Status.loading,
      this.posts = const [],
      this.indexPost = 0,
      this.hasReachedMaxPost = false,
      this.isLoading = false});

  GroupDetailState copyWith({
    Group? group,
    Status? statusPost,
    List<Post>? posts,
    int? indexPost,
    bool? hasReachedMaxPost,
    bool? isLoading,
  }) {
    return GroupDetailState(
        group: group ?? this.group,
        statusPost: statusPost ?? this.statusPost,
        posts: posts ?? this.posts,
        indexPost: indexPost ?? this.indexPost,
        hasReachedMaxPost: hasReachedMaxPost ?? this.hasReachedMaxPost,
        isLoading: isLoading ?? this.isLoading);
  }
}
