import 'package:hcmus_alumni_mobile/model/comment.dart';
import 'package:hcmus_alumni_mobile/model/education.dart';
import 'package:hcmus_alumni_mobile/model/event.dart';
import 'package:hcmus_alumni_mobile/model/friend.dart';
import 'package:hcmus_alumni_mobile/model/user.dart';

import '../../../model/achievement.dart';
import '../../../model/alumni_verification.dart';
import '../../../model/job.dart';
import '../../../model/post.dart';
import 'my_profile_page_states.dart';

class MyProfilePageEvent {
  const MyProfilePageEvent();
}

class UserEvent extends MyProfilePageEvent {
  final User user;

  const UserEvent(this.user);
}

class AlumniVerificationEvent extends MyProfilePageEvent {
  final AlumniVerification alumniVerification;

  const AlumniVerificationEvent(this.alumniVerification);
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

class FriendCountEvent extends MyProfilePageEvent {
  final int friendCount;

  const FriendCountEvent(this.friendCount);
}

class FriendsEvent extends MyProfilePageEvent {
  final List<Friend> friends;

  const FriendsEvent(this.friends);
}