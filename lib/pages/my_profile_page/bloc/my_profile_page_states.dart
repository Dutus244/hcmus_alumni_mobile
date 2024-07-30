import 'package:hcmus_alumni_mobile/model/achievement.dart';
import 'package:hcmus_alumni_mobile/model/alumni_verification.dart';

import '../../../model/comment.dart';
import '../../../model/education.dart';
import '../../../model/event.dart';
import '../../../model/friend.dart';
import '../../../model/job.dart';
import '../../../model/post.dart';
import '../../../model/user.dart';

enum Status { loading, success }

class MyProfilePageState {
  final User? user;
  final AlumniVerification? alumniVerification;
  final int page;
  final Status statusPost;
  final List<Post> posts;
  final int indexPost;
  final bool hasReachedMaxPost;
  final Status statusEvent;
  final List<Event> events;
  final int indexEvent;
  final bool hasReachedMaxEvent;
  final Status statusCommentAdvise;
  final List<Comment> commentAdvises;
  final int indexCommentAdvise;
  final bool hasReachedMaxCommentAdvise;
  final List<Education> educations;
  final List<Job> jobs;
  final List<Achievement> achievements;
  final int friendCount;
  final List<Friend> friends;

  MyProfilePageState(
      {this.user,
      this.alumniVerification,
      this.page = 0,
      this.statusPost = Status.loading,
      this.posts = const [],
      this.indexPost = 0,
      this.hasReachedMaxPost = false,
      this.statusEvent = Status.loading,
      this.events = const [],
      this.indexEvent = 0,
      this.hasReachedMaxEvent = false,
      this.statusCommentAdvise = Status.loading,
      this.commentAdvises = const [],
      this.indexCommentAdvise = 0,
      this.hasReachedMaxCommentAdvise = false,
      this.educations = const [],
      this.jobs = const [],
      this.achievements = const [],
      this.friendCount = 0,
      this.friends = const []});

  MyProfilePageState copyWith(
      {User? user,
      AlumniVerification? alumniVerification,
      int? page,
      Status? statusPost,
      List<Post>? posts,
      int? indexPost,
      bool? hasReachedMaxPost,
      Status? statusEvent,
      List<Event>? events,
      int? indexEvent,
      bool? hasReachedMaxEvent,
      Status? statusCommentAdvise,
      List<Comment>? commentAdvises,
      int? indexCommentAdvise,
      bool? hasReachedMaxCommentAdvise,
      List<Education>? educations,
      List<Job>? jobs,
      List<Achievement>? achievements,
      int? friendCount,
      List<Friend>? friends}) {
    return MyProfilePageState(
        user: user ?? this.user,
        alumniVerification: alumniVerification ?? this.alumniVerification,
        page: page ?? this.page,
        statusPost: statusPost ?? this.statusPost,
        posts: posts ?? this.posts,
        indexPost: indexPost ?? this.indexPost,
        hasReachedMaxPost: hasReachedMaxPost ?? this.hasReachedMaxPost,
        statusEvent: statusEvent ?? this.statusEvent,
        events: events ?? this.events,
        indexEvent: indexEvent ?? this.indexEvent,
        hasReachedMaxEvent: hasReachedMaxEvent ?? this.hasReachedMaxEvent,
        statusCommentAdvise: statusCommentAdvise ?? this.statusCommentAdvise,
        commentAdvises: commentAdvises ?? this.commentAdvises,
        indexCommentAdvise: indexCommentAdvise ?? this.indexCommentAdvise,
        hasReachedMaxCommentAdvise:
            hasReachedMaxCommentAdvise ?? this.hasReachedMaxCommentAdvise,
        educations: educations ?? this.educations,
        jobs: jobs ?? this.jobs,
        achievements: achievements ?? this.achievements,
        friendCount: friendCount ?? this.friendCount,
        friends: friends ?? this.friends);
  }
}
