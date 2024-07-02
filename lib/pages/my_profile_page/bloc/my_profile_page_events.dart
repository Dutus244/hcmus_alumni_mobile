import 'package:hcmus_alumni_mobile/model/comment.dart';
import 'package:hcmus_alumni_mobile/model/education.dart';
import 'package:hcmus_alumni_mobile/model/event.dart';

import '../../../model/achievement.dart';
import '../../../model/job.dart';
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

class StatusCommentAdviseEvent extends MyProfilePageEvent {
  final Status statusCommentAdvise;

  const StatusCommentAdviseEvent(this.statusCommentAdvise);
}

class CommentAdvisesEvent extends MyProfilePageEvent {
  final List<Comment> commentAdvises;

  const CommentAdvisesEvent(this.commentAdvises);
}

class IndexCommentAdviseEvent extends MyProfilePageEvent {
  final int indexCommentAdvise;

  const IndexCommentAdviseEvent(this.indexCommentAdvise);
}

class HasReachedMaxCommentAdviseEvent extends MyProfilePageEvent {
  final bool hasReachedMaxCommentAdvise;

  const HasReachedMaxCommentAdviseEvent(this.hasReachedMaxCommentAdvise);
}

class EducationsEvent extends MyProfilePageEvent {
  final List<Education> educations;

  const EducationsEvent(this.educations);
}

class JobsEvent extends MyProfilePageEvent {
  final List<Job> jobs;

  const JobsEvent(this.jobs);
}

class AchievementsEvent extends MyProfilePageEvent {
  final List<Achievement> achievements;

  const AchievementsEvent(this.achievements);
}