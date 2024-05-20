import 'package:flutter_bloc/flutter_bloc.dart';

import 'group_page_events.dart';
import 'group_page_states.dart';

class GroupPageBloc extends Bloc<GroupPageEvent, GroupPageState> {
  GroupPageBloc() : super(GroupPageState()) {
    on<PageEvent>(_pageEvent);
    on<StatusGroupDiscoverEvent>(_statusGroupDiscoverEvent);
    on<GroupDiscoverEvent>(_groupDiscoverEvent);
    on<IndexGroupDiscoverEvent>(_indexGroupDiscoverEvent);
    on<HasReachedMaxGroupDiscoverEvent>(_hasReachedMaxGroupDiscoverEvent);
    on<StatusGroupJoinedEvent>(_statusGroupJoinedEvent);
    on<GroupJoinedEvent>(_groupJoinedEvent);
    on<IndexGroupJoinedEvent>(_indexGroupJoinedEvent);
    on<HasReachedMaxGroupJoinedEvent>(_hasReachedMaxGroupJoinedEvent);
  }

  void _pageEvent(PageEvent event, Emitter<GroupPageState> emit) {
    emit(state.copyWith(page: event.page));
  }

  void _statusGroupDiscoverEvent(
      StatusGroupDiscoverEvent event, Emitter<GroupPageState> emit) async {
    emit(state.copyWith(statusGroupDiscover: event.statusGroupDiscover));
  }

  void _groupDiscoverEvent(
      GroupDiscoverEvent event, Emitter<GroupPageState> emit) async {
    emit(state.copyWith(groupDiscover: event.groupDiscover));
  }

  void _indexGroupDiscoverEvent(
      IndexGroupDiscoverEvent event, Emitter<GroupPageState> emit) {
    emit(state.copyWith(indexGroupDiscover: event.indexGroupDiscover));
  }

  void _hasReachedMaxGroupDiscoverEvent(
      HasReachedMaxGroupDiscoverEvent event, Emitter<GroupPageState> emit) {
    emit(state.copyWith(
        hasReachedMaxGroupDiscover: event.hasReachedMaxGroupDiscover));
  }

  void _statusGroupJoinedEvent(
      StatusGroupJoinedEvent event, Emitter<GroupPageState> emit) async {
    emit(state.copyWith(statusGroupJoined: event.statusGroupJoined));
  }

  void _groupJoinedEvent(
      GroupJoinedEvent event, Emitter<GroupPageState> emit) async {
    emit(state.copyWith(groupJoined: event.groupJoined));
  }

  void _indexGroupJoinedEvent(
      IndexGroupJoinedEvent event, Emitter<GroupPageState> emit) {
    emit(state.copyWith(indexGroupJoined: event.indexGroupJoined));
  }

  void _hasReachedMaxGroupJoinedEvent(
      HasReachedMaxGroupJoinedEvent event, Emitter<GroupPageState> emit) {
    emit(state.copyWith(
        hasReachedMaxGroupJoined: event.hasReachedMaxGroupJoined));
  }
}
