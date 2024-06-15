import 'package:flutter_bloc/flutter_bloc.dart';

import 'friend_page_events.dart';
import 'friend_page_states.dart';

class FriendPageBloc extends Bloc<FriendPageEvent, FriendPageState> {
  FriendPageBloc() : super(FriendPageState()) {
    on<PageEvent>(_pageEvent);
    on<NameEvent>(_nameEvent);
    on<NameSearchEvent>(_nameSearchEvent);
    on<StatusSuggestionEvent>(_statusSuggestionEvent);
    on<FriendSuggestionsEvent>(_friendSuggestionsEvent);
    on<IndexSuggestionEvent>(_indexSuggestionEvent);
    on<HasReachedMaxSuggestionEvent>(_hasReachedMaxSuggestionEvent);
    on<StatusRequestEvent>(_statusRequestEvent);
    on<FriendRequestsEvent>(_friendRequestsEvent);
    on<IndexRequestEvent>(_indexRequestEvent);
    on<HasReachedMaxRequestEvent>(_hasReachedMaxRequestEvent);
  }

  void _pageEvent(PageEvent event, Emitter<FriendPageState> emit) async {
    emit(state.copyWith(page: event.page));
  }

  void _nameEvent(NameEvent event, Emitter<FriendPageState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _nameSearchEvent(NameSearchEvent event, Emitter<FriendPageState> emit) {
    emit(state.copyWith(nameSearch: event.nameSearch));
  }

  void _statusSuggestionEvent(
      StatusSuggestionEvent event, Emitter<FriendPageState> emit) async {
    emit(state.copyWith(statusSuggestion: event.statusSuggestion));
  }

  void _friendSuggestionsEvent(
      FriendSuggestionsEvent event, Emitter<FriendPageState> emit) async {
    emit(state.copyWith(friendSuggestions: event.friendSuggestions));
  }

  void _indexSuggestionEvent(
      IndexSuggestionEvent event, Emitter<FriendPageState> emit) {
    emit(state.copyWith(indexSuggestion: event.indexSuggestion));
  }

  void _hasReachedMaxSuggestionEvent(
      HasReachedMaxSuggestionEvent event, Emitter<FriendPageState> emit) {
    emit(
        state.copyWith(hasReachedMaxSuggestion: event.hasReachedMaxSuggestion));
  }

  void _statusRequestEvent(
      StatusRequestEvent event, Emitter<FriendPageState> emit) async {
    emit(state.copyWith(statusRequest: event.statusRequest));
  }

  void _friendRequestsEvent(
      FriendRequestsEvent event, Emitter<FriendPageState> emit) async {
    emit(state.copyWith(friendRequests: event.friendRequests));
  }

  void _indexRequestEvent(
      IndexRequestEvent event, Emitter<FriendPageState> emit) {
    emit(state.copyWith(indexRequest: event.indexRequest));
  }

  void _hasReachedMaxRequestEvent(
      HasReachedMaxRequestEvent event, Emitter<FriendPageState> emit) {
    emit(state.copyWith(hasReachedMaxRequest: event.hasReachedMaxRequest));
  }
}
