import '../../../model/achievement.dart';
import '../../../model/education.dart';
import '../../../model/event.dart';
import '../../../model/friend.dart';
import '../../../model/job.dart';
import '../../../model/user.dart';

enum Status { loading, success }

class OtherProfilePageState {
  final Status statusEvent;
  final List<Event> events;
  final int indexEvent;
  final bool hasReachedMaxEvent;

  final User? user;
  final int friendCount;
  final List<Friend> friends;
  final List<Education> educations;
  final List<Job> jobs;
  final List<Achievement> achievements;

  final String isFriendStatus;

  final bool isLoading;

  OtherProfilePageState({
    this.statusEvent = Status.loading,
    this.events = const [],
    this.indexEvent = 0,
    this.hasReachedMaxEvent = false,
    this.user,
    this.friendCount = 0,
    this.friends = const [],
    this.educations = const [],
    this.jobs = const [],
    this.achievements = const [],
    this.isFriendStatus = "",
    this.isLoading = false,
  });

  OtherProfilePageState copyWith({
    Status? statusEvent,
    List<Event>? events,
    int? indexEvent,
    bool? hasReachedMaxEvent,
    User? user,
    int? friendCount,
    List<Friend>? friends,
    List<Education>? educations,
    List<Job>? jobs,
    List<Achievement>? achievements,
    String? isFriendStatus,
    bool? isLoading,
  }) {
    return OtherProfilePageState(
      statusEvent: statusEvent ?? this.statusEvent,
      events: events ?? this.events,
      indexEvent: indexEvent ?? this.indexEvent,
      hasReachedMaxEvent: hasReachedMaxEvent ?? this.hasReachedMaxEvent,
      user: user ?? this.user,
      friendCount: friendCount ?? this.friendCount,
      friends: friends ?? this.friends,
      educations: educations ?? this.educations,
      jobs: jobs ?? this.jobs,
      achievements: achievements ?? this.achievements,
      isFriendStatus: isFriendStatus ?? this.isFriendStatus,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
