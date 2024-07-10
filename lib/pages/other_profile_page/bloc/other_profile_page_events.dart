import 'package:hcmus_alumni_mobile/model/event.dart';

import '../../../model/achievement.dart';
import '../../../model/education.dart';
import '../../../model/friend.dart';
import '../../../model/job.dart';
import '../../../model/post.dart';
import '../../../model/user.dart';
import 'other_profile_page_states.dart';

class OtherProfilePageEvent {
  const OtherProfilePageEvent();
}

class StatusEventEvent extends OtherProfilePageEvent {
  final Status statusEvent;

  const StatusEventEvent(this.statusEvent);
}

class EventsEvent extends OtherProfilePageEvent {
  final List<Event> events;

  const EventsEvent(this.events);
}

class IndexEventEvent extends OtherProfilePageEvent {
  final int indexEvent;

  const IndexEventEvent(this.indexEvent);
}

class HasReachedMaxEventEvent extends OtherProfilePageEvent {
  final bool hasReachedMaxEvent;

  const HasReachedMaxEventEvent(this.hasReachedMaxEvent);
}

class UserEvent extends OtherProfilePageEvent {
  final User user;

  const UserEvent(this.user);
}

class EducationsEvent extends OtherProfilePageEvent {
  final List<Education> educations;

  const EducationsEvent(this.educations);
}

class JobsEvent extends OtherProfilePageEvent {
  final List<Job> jobs;

  const JobsEvent(this.jobs);
}

class AchievementsEvent extends OtherProfilePageEvent {
  final List<Achievement> achievements;

  const AchievementsEvent(this.achievements);
}

class FriendCountEvent extends OtherProfilePageEvent {
  final int friendCount;

  const FriendCountEvent(this.friendCount);
}

class FriendsEvent extends OtherProfilePageEvent {
  final List<Friend> friends;

  const FriendsEvent(this.friends);
}

class IsFriendStatusEvent extends OtherProfilePageEvent {
  final String isFriendStatus;

  const IsFriendStatusEvent(this.isFriendStatus);
}