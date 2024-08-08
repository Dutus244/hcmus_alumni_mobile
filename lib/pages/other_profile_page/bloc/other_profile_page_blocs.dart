import 'package:flutter_bloc/flutter_bloc.dart';

import 'other_profile_page_events.dart';
import 'other_profile_page_states.dart';

class OtherProfilePageBloc extends Bloc<OtherProfilePageEvent, OtherProfilePageState> {
  OtherProfilePageBloc() : super(OtherProfilePageState()) {
    on<StatusEventEvent>(_statusEventEvent);
    on<EventsEvent>(_eventsEvent);
    on<IndexEventEvent>(_indexEventEvent);
    on<HasReachedMaxEventEvent>(_hasReachedMaxEventEvent);
    on<UserEvent>(_userEvent);
    on<EducationsEvent>(_educationsEvent);
    on<JobsEvent>(_jobsEvent);
    on<AchievementsEvent>(_achievementsEvent);
    on<FriendCountEvent>(_friendCountEvent);
    on<FriendsEvent>(_friendsEvent);
    on<IsLoadingEvent>(_isLoadingEvent);
    on<IsFriendStatusEvent>(_isFriendStatusEvent);
    on<OtherProfileResetEvent>(_otherProfileResetEvent);
  }

  void _statusEventEvent(
      StatusEventEvent event, Emitter<OtherProfilePageState> emit) async {
    emit(state.copyWith(statusEvent: event.statusEvent));
  }

  void _eventsEvent(EventsEvent event, Emitter<OtherProfilePageState> emit) async {
    emit(state.copyWith(events: event.events));
  }

  void _indexEventEvent(
      IndexEventEvent event, Emitter<OtherProfilePageState> emit) {
    emit(state.copyWith(indexEvent: event.indexEvent));
  }

  void _hasReachedMaxEventEvent(
      HasReachedMaxEventEvent event, Emitter<OtherProfilePageState> emit) {
    emit(state.copyWith(hasReachedMaxEvent: event.hasReachedMaxEvent));
  }

  void _userEvent(
      UserEvent event, Emitter<OtherProfilePageState> emit) {
    emit(state.copyWith(user: event.user));
  }

  void _educationsEvent(EducationsEvent event, Emitter<OtherProfilePageState> emit) async {
    emit(state.copyWith(educations: event.educations));
  }

  void _jobsEvent(JobsEvent event, Emitter<OtherProfilePageState> emit) async {
    emit(state.copyWith(jobs: event.jobs));
  }

  void _achievementsEvent(AchievementsEvent event, Emitter<OtherProfilePageState> emit) async {
    emit(state.copyWith(achievements: event.achievements));
  }

  void _friendCountEvent(FriendCountEvent event, Emitter<OtherProfilePageState> emit) async {
    emit(state.copyWith(friendCount: event.friendCount));
  }

  void _friendsEvent(FriendsEvent event, Emitter<OtherProfilePageState> emit) async {
    emit(state.copyWith(friends: event.friends));
  }

  void _isLoadingEvent(IsLoadingEvent event, Emitter<OtherProfilePageState> emit) async {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _isFriendStatusEvent(IsFriendStatusEvent event, Emitter<OtherProfilePageState> emit) async {
    emit(state.copyWith(isFriendStatus: event.isFriendStatus));
  }

  void _otherProfileResetEvent(OtherProfileResetEvent event, Emitter<OtherProfilePageState> emit) async {
    emit(OtherProfilePageState());
  }
}