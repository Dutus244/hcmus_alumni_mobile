import 'package:flutter_bloc/flutter_bloc.dart';

import 'group_search_events.dart';
import 'group_search_states.dart';

class GroupSearchBloc extends Bloc<GroupSearchEvent, GroupSearchState> {
  GroupSearchBloc() : super(GroupSearchState()) {
    on<NameEvent>(_nameEvent);
    on<NameSearchEvent>(_nameSearchEvent);
    on<GroupSearchResetEvent>(_groupSearchResetEvent);
    on<StatusEvent>(_statusEvent);
    on<GroupsEvent>(_groupsEvent);
    on<IndexGroupEvent>(_indexGroupEvent);
    on<HasReachedMaxGroupEvent>(_hasReachedMaxGroupEvent);
    on<IsLoadingEvent>(_isLoadingEvent);
    on<ClearResultEvent>(_clearResultEvent);
  }

  void _nameEvent(NameEvent event, Emitter<GroupSearchState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _nameSearchEvent(NameSearchEvent event, Emitter<GroupSearchState> emit) {
    emit(state.copyWith(nameSearch: event.nameSearch));
  }

  void _statusEvent(StatusEvent event, Emitter<GroupSearchState> emit) async {
    emit(state.copyWith(status: event.status));
  }

  void _groupsEvent(GroupsEvent event, Emitter<GroupSearchState> emit) async {
    emit(state.copyWith(groups: event.groups));
  }

  void _indexGroupEvent(IndexGroupEvent event, Emitter<GroupSearchState> emit) {
    emit(state.copyWith(indexGroup: event.indexGroup));
  }

  void _hasReachedMaxGroupEvent(
      HasReachedMaxGroupEvent event, Emitter<GroupSearchState> emit) {
    emit(state.copyWith(hasReachedMaxGroup: event.hasReachedMaxGroup));
  }

  void _isLoadingEvent(
      IsLoadingEvent event, Emitter<GroupSearchState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _groupSearchResetEvent(
      GroupSearchResetEvent event, Emitter<GroupSearchState> emit) {
    emit(GroupSearchState()); // Reset the state to its initial state
  }

  void _clearResultEvent(
      ClearResultEvent event, Emitter<GroupSearchState> emit) {
    emit(state.copyWith(
        status: Status.loading,
        groups: const [],
        indexGroup: 0,
        hasReachedMaxGroup: false));
  }
}
