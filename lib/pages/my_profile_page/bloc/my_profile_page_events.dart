import 'package:hcmus_alumni_mobile/model/event.dart';

import '../../../model/post.dart';
import 'my_profile_page_states.dart';

class MyProfilePageEvent {
  const MyProfilePageEvent();
}

class PageEvent extends MyProfilePageEvent {
  final int page;

  const PageEvent(this.page);
}

class StatusPostEvent extends MyProfilePageEvent {
  final Status statusPost;

  const StatusPostEvent(this.statusPost);
}

class PostsEvent extends MyProfilePageEvent {
  final List<Post> posts;

  const PostsEvent(this.posts);
}

class IndexPostEvent extends MyProfilePageEvent {
  final int indexPost;

  const IndexPostEvent(this.indexPost);
}

class HasReachedMaxPostEvent extends MyProfilePageEvent {
  final bool hasReachedMaxPost;

  const HasReachedMaxPostEvent(this.hasReachedMaxPost);
}

class StatusEventEvent extends MyProfilePageEvent {
  final Status statusEvent;

  const StatusEventEvent(this.statusEvent);
}

class EventsEvent extends MyProfilePageEvent {
  final List<Event> events;

  const EventsEvent(this.events);
}

class IndexEventEvent extends MyProfilePageEvent {
  final int indexEvent;

  const IndexEventEvent(this.indexEvent);
}

class HasReachedMaxEventEvent extends MyProfilePageEvent {
  final bool hasReachedMaxEvent;

  const HasReachedMaxEventEvent(this.hasReachedMaxEvent);
}