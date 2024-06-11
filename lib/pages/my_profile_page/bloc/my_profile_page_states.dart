import '../../../model/event.dart';
import '../../../model/post.dart';

enum Status { loading, success }

class MyProfilePageState {
  final int page;
  final Status statusPost;
  final List<Post> posts;
  final int indexPost;
  final bool hasReachedMaxPost;
  final Status statusEvent;
  final List<Event> events;
  final int indexEvent;
  final bool hasReachedMaxEvent;

  MyProfilePageState({
    this.page = 0,
    this.statusPost = Status.loading,
    this.posts = const [],
    this.indexPost = 0,
    this.hasReachedMaxPost = false,
    this.statusEvent = Status.loading,
    this.events = const [],
    this.indexEvent = 0,
    this.hasReachedMaxEvent = false,
  });

  MyProfilePageState copyWith({
    int? page,
    Status? statusPost,
    List<Post>? posts,
    int? indexPost,
    bool? hasReachedMaxPost,
    Status? statusEvent,
    List<Event>? events,
    int? indexEvent,
    bool? hasReachedMaxEvent,
  }) {
    return MyProfilePageState(
        page: page ?? this.page,
        statusPost: statusPost ?? this.statusPost,
        posts: posts ?? this.posts,
        indexPost: indexPost ?? this.indexPost,
        hasReachedMaxPost: hasReachedMaxPost ?? this.hasReachedMaxPost,
        statusEvent: statusEvent ?? this.statusEvent,
        events: events ?? this.events,
        indexEvent: indexEvent ?? this.indexEvent,
        hasReachedMaxEvent: hasReachedMaxEvent ?? this.hasReachedMaxEvent);
  }
}
