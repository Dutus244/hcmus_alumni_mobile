import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_profile_page_events.dart';
import 'my_profile_page_states.dart';

class MyProfilePageBloc extends Bloc<MyProfilePageEvent, MyProfilePageState> {
  MyProfilePageBloc() : super(MyProfilePageState()) {
    on<UserEvent>(_userEvent);
    on<AlumniVerificationEvent>(_alumniVerificationEvent);
    on<PageEvent>(_pageEvent);
    on<StatusPostEvent>(_statusPostEvent);
    on<PostsEvent>(_postsEvent);
    on<IndexPostEvent>(_indexPostEvent);
    on<HasReachedMaxPostEvent>(_hasReachedMaxPostEvent);
    on<StatusEventEvent>(_statusEventEvent);
    on<EventsEvent>(_eventsEvent);
    on<IndexEventEvent>(_indexEventEvent);
    on<HasReachedMaxEventEvent>(_hasReachedMaxEventEvent);
    on<StatusCommentAdviseEvent>(_statusCommentAdviseEvent);
    on<CommentAdvisesEvent>(_commentAdvisesEvent);
    on<IndexCommentAdviseEvent>(_indexCommentAdviseEvent);
    on<HasReachedMaxCommentAdviseEvent>(_hasReachedMaxCommentAdviseEvent);
    on<EducationsEvent>(_educationsEvent);
    on<JobsEvent>(_jobsEvent);
    on<AchievementsEvent>(_achievementsEvent);
    on<FriendCountEvent>(_friendCountEvent);
    on<FriendsEvent>(_friendsEvent);
  }

  void _userEvent(UserEvent event, Emitter<MyProfilePageState> emit) {
    emit(state.copyWith(user: event.user));
  }

  void _alumniVerificationEvent(AlumniVerificationEvent event, Emitter<MyProfilePageState> emit) {
    emit(state.copyWith(alumniVerification: event.alumniVerification));
  }

  void _pageEvent(PageEvent event, Emitter<MyProfilePageState> emit) {
    emit(state.copyWith(page: event.page));
  }

  void _statusPostEvent(
      StatusPostEvent event, Emitter<MyProfilePageState> emit) async {
    emit(state.copyWith(statusPost: event.statusPost));
  }

  void _postsEvent(PostsEvent event, Emitter<MyProfilePageState> emit) async {
    emit(state.copyWith(posts: event.posts));
  }

  void _indexPostEvent(IndexPostEvent event, Emitter<MyProfilePageState> emit) {
    emit(state.copyWith(indexPost: event.indexPost));
  }

  void _hasReachedMaxPostEvent(
      HasReachedMaxPostEvent event, Emitter<MyProfilePageState> emit) {
    emit(state.copyWith(hasReachedMaxPost: event.hasReachedMaxPost));
  }

  void _statusEventEvent(
      StatusEventEvent event, Emitter<MyProfilePageState> emit) async {
    emit(state.copyWith(statusEvent: event.statusEvent));
  }

  void _eventsEvent(EventsEvent event, Emitter<MyProfilePageState> emit) async {
    emit(state.copyWith(events: event.events));
  }

  void _indexEventEvent(
      IndexEventEvent event, Emitter<MyProfilePageState> emit) {
    emit(state.copyWith(indexEvent: event.indexEvent));
  }

  void _hasReachedMaxEventEvent(
      HasReachedMaxEventEvent event, Emitter<MyProfilePageState> emit) {
    emit(state.copyWith(hasReachedMaxEvent: event.hasReachedMaxEvent));
  }

  void _statusCommentAdviseEvent(
      StatusCommentAdviseEvent event, Emitter<MyProfilePageState> emit) async {
    emit(state.copyWith(statusCommentAdvise: event.statusCommentAdvise));
  }

  void _commentAdvisesEvent(CommentAdvisesEvent event, Emitter<MyProfilePageState> emit) async {
    emit(state.copyWith(commentAdvises: event.commentAdvises));
  }

  void _indexCommentAdviseEvent(
      IndexCommentAdviseEvent event, Emitter<MyProfilePageState> emit) {
    emit(state.copyWith(indexCommentAdvise: event.indexCommentAdvise));
  }

  void _hasReachedMaxCommentAdviseEvent(
      HasReachedMaxCommentAdviseEvent event, Emitter<MyProfilePageState> emit) {
    emit(state.copyWith(hasReachedMaxCommentAdvise: event.hasReachedMaxCommentAdvise));
  }

  void _educationsEvent(EducationsEvent event, Emitter<MyProfilePageState> emit) async {
    emit(state.copyWith(educations: event.educations));
  }

  void _jobsEvent(JobsEvent event, Emitter<MyProfilePageState> emit) async {
    emit(state.copyWith(jobs: event.jobs));
  }

  void _achievementsEvent(AchievementsEvent event, Emitter<MyProfilePageState> emit) async {
    emit(state.copyWith(achievements: event.achievements));
  }

  void _friendCountEvent(FriendCountEvent event, Emitter<MyProfilePageState> emit) async {
    emit(state.copyWith(friendCount: event.friendCount));
  }

  void _friendsEvent(FriendsEvent event, Emitter<MyProfilePageState> emit) async {
    emit(state.copyWith(friends: event.friends));
  }
}