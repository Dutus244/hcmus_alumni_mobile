import 'package:flutter_bloc/flutter_bloc.dart';

import 'friend_list_events.dart';
import 'friend_list_states.dart';

class FriendListBloc extends Bloc<FriendListEvent, FriendListState> {
  FriendListBloc() : super(FriendListState()) {
    on<NameEvent>(_nameEvent);
    on<NameSearchEvent>(_nameSearchEvent);
    on<FriendSearchResetEvent>(_friendSearchResetEvent);
    on<StatusEvent>(_statusEvent);
    on<FriendsEvent>(_friendsEvent);
    on<IndexFriendEvent>(_indexFriendEvent);
    on<HasReachedMaxFriendEvent>(_hasReachedMaxFriendEvent);
    on<ClearResultEvent>(_clearResultEvent);
    on<FriendCountEvent>(_friendCountEvent);
    on<IsLoadingEvent>(_isLoadingEvent);
  }

  void _nameEvent(NameEvent event, Emitter<FriendListState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _nameSearchEvent(NameSearchEvent event, Emitter<FriendListState> emit) {
    emit(state.copyWith(nameSearch: event.nameSearch));
  }

  void _statusEvent(StatusEvent event, Emitter<FriendListState> emit) async {
    emit(state.copyWith(status: event.status));
  }

  void _friendsEvent(FriendsEvent event, Emitter<FriendListState> emit) async {
    emit(state.copyWith(friends: event.friends));
  }

  void _indexFriendEvent(IndexFriendEvent event, Emitter<FriendListState> emit) {
    emit(state.copyWith(indexFriend: event.indexFriend));
  }

  void _hasReachedMaxFriendEvent(
      HasReachedMaxFriendEvent event, Emitter<FriendListState> emit) {
    emit(state.copyWith(hasReachedMaxFriend: event.hasReachedMaxFriend));
  }

  void _isLoadingEvent(
      IsLoadingEvent event, Emitter<FriendListState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _friendSearchResetEvent(
      FriendSearchResetEvent event, Emitter<FriendListState> emit) {
    emit(FriendListState()); // Reset the state to its initial state
  }

  void _clearResultEvent(
      ClearResultEvent event, Emitter<FriendListState> emit) {
    emit(state.copyWith(
        status: Status.loading,
        friends: const [],
        indexFriend: 0,
        hasReachedMaxFriend: false));
  }

  void _friendCountEvent(
      FriendCountEvent event, Emitter<FriendListState> emit) {
    emit(state.copyWith(friendCount: event.friendCount));
  }
}
