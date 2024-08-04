import 'package:flutter_bloc/flutter_bloc.dart';

import 'group_detail_events.dart';
import 'group_detail_states.dart';

class GroupDetailBloc extends Bloc<GroupDetailEvent, GroupDetailState> {
  GroupDetailBloc() : super(GroupDetailState()) {
    on<GroupEvent>(_groupEvent);
    on<StatusPostEvent>(_statusPostEvent);
    on<PostsEvent>(_postsEvent);
    on<IndexPostEvent>(_indexPostEvent);
    on<IsLoadingEvent>(_isLoadingEvent);
    on<HasReachedMaxPostEvent>(_hasReachedMaxPostEvent);
  }

  void _groupEvent(GroupEvent event, Emitter<GroupDetailState> emit) {
    emit(state.copyWith(group: event.group));
  }

  void _statusPostEvent(
      StatusPostEvent event, Emitter<GroupDetailState> emit) async {
    emit(state.copyWith(statusPost: event.statusPost));
  }

  void _postsEvent(PostsEvent event, Emitter<GroupDetailState> emit) async {
    emit(state.copyWith(posts: event.posts));
  }

  void _indexPostEvent(IndexPostEvent event, Emitter<GroupDetailState> emit) {
    emit(state.copyWith(indexPost: event.indexPost));
  }

  void _isLoadingEvent(IsLoadingEvent event, Emitter<GroupDetailState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _hasReachedMaxPostEvent(
      HasReachedMaxPostEvent event, Emitter<GroupDetailState> emit) {
    emit(state.copyWith(hasReachedMaxPost: event.hasReachedMaxPost));
  }
}
