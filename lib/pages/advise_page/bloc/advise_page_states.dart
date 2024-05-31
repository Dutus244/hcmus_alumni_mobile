import 'package:hcmus_alumni_mobile/model/post.dart';

import '../../../model/voter.dart';

enum Status { loading, success }

class AdvisePageState {
  final Status statusPost;
  final List<Post> posts;
  final int indexPost;
  final bool hasReachedMaxPost;
  final Status statusVoter;
  final List<Voter> voters;
  final int indexVoter;
  final bool hasReachedMaxVoter;


  AdvisePageState({
    this.statusPost = Status.loading,
    this.posts = const [],
    this.indexPost = 0,
    this.hasReachedMaxPost = false,
    this.statusVoter = Status.loading,
    this.voters = const [],
    this.indexVoter = 0,
    this.hasReachedMaxVoter = false
  });

  AdvisePageState copyWith({
    Status? statusPost,
    List<Post>? posts,
    int? indexPost,
    bool? hasReachedMaxPost,
    Status? statusVoter,
    List<Voter>? voters,
    int? indexVoter,
    bool? hasReachedMaxVoter,
  }) {
    return AdvisePageState(
        statusPost: statusPost ?? this.statusPost,
        posts: posts ?? this.posts,
        indexPost: indexPost ?? this.indexPost,
        hasReachedMaxPost: hasReachedMaxPost ?? this.hasReachedMaxPost,
        statusVoter: statusVoter ?? this.statusVoter,
        voters: voters ?? this.voters,
        indexVoter: indexVoter ?? this.indexVoter,
        hasReachedMaxVoter: hasReachedMaxVoter ?? this.hasReachedMaxVoter);
  }
}
