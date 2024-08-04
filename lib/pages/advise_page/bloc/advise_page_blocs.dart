import 'package:flutter_bloc/flutter_bloc.dart';

import 'advise_page_events.dart';
import 'advise_page_states.dart';

class AdvisePageBloc extends Bloc<AdvisePageEvent, AdvisePageState> {
  AdvisePageBloc() : super(AdvisePageState()) {
    on<StatusPostEvent>(_statusPostEvent);
    on<PostsEvent>(_postsEvent);
    on<IndexPostEvent>(_indexPostEvent);
    on<HasReachedMaxPostEvent>(_hasReachedMaxPostEvent);
    on<StatusVoterEvent>(_statusVoterEvent);
    on<VotersEvent>(_votersEvent);
    on<IndexVoterEvent>(_indexVoterEvent);
    on<IsLoadingEvent>(_isLoadingEvent);
    on<HasReachedMaxVoterEvent>(_hasReachedMaxVoterEvent);
  }

  void _statusPostEvent(
      StatusPostEvent event, Emitter<AdvisePageState> emit) async {
    emit(state.copyWith(statusPost: event.statusPost));
  }

  void _postsEvent(PostsEvent event, Emitter<AdvisePageState> emit) async {
    emit(state.copyWith(posts: event.posts));
  }

  void _indexPostEvent(IndexPostEvent event, Emitter<AdvisePageState> emit) {
    emit(state.copyWith(indexPost: event.indexPost));
  }

  void _hasReachedMaxPostEvent(
      HasReachedMaxPostEvent event, Emitter<AdvisePageState> emit) {
    emit(state.copyWith(hasReachedMaxPost: event.hasReachedMaxPost));
  }

  void _statusVoterEvent(
      StatusVoterEvent event, Emitter<AdvisePageState> emit) async {
    emit(state.copyWith(statusVoter: event.statusVoter));
  }

  void _votersEvent(VotersEvent event, Emitter<AdvisePageState> emit) async {
    emit(state.copyWith(voters: event.voters));
  }

  void _indexVoterEvent(IndexVoterEvent event, Emitter<AdvisePageState> emit) {
    emit(state.copyWith(indexVoter: event.indexVoter));
  }

  void _hasReachedMaxVoterEvent(
      HasReachedMaxVoterEvent event, Emitter<AdvisePageState> emit) {
    emit(state.copyWith(hasReachedMaxVoter: event.hasReachedMaxVoter));
  }

  void _isLoadingEvent(
      IsLoadingEvent event, Emitter<AdvisePageState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }
}
