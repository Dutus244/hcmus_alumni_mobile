import 'package:flutter_bloc/flutter_bloc.dart';

import 'group_detail_list_voters_events.dart';
import 'group_detail_list_voters_states.dart';

class GroupDetailListVotersBloc extends Bloc<GroupDetailListVotersEvent, GroupDetailListVotersState> {
  GroupDetailListVotersBloc() : super(GroupDetailListVotersState()) {
    on<StatusVoterEvent>(_statusVoterEvent);
    on<VotersEvent>(_votersEvent);
    on<IndexVoterEvent>(_indexVoterEvent);
    on<HasReachedMaxVoterEvent>(_hasReachedMaxVoterEvent);
    on<GroupDetailListVotersResetEvent>(_groupDetailListVotersResetEvent);
  }

  void _statusVoterEvent(
      StatusVoterEvent event, Emitter<GroupDetailListVotersState> emit) async {
    emit(state.copyWith(statusVoter: event.statusVoter));
  }

  void _votersEvent(VotersEvent event, Emitter<GroupDetailListVotersState> emit) async {
    emit(state.copyWith(voters: event.voters));
  }

  void _indexVoterEvent(IndexVoterEvent event, Emitter<GroupDetailListVotersState> emit) {
    emit(state.copyWith(indexVoter: event.indexVoter));
  }

  void _hasReachedMaxVoterEvent(
      HasReachedMaxVoterEvent event, Emitter<GroupDetailListVotersState> emit) {
    emit(state.copyWith(hasReachedMaxVoter: event.hasReachedMaxVoter));
  }

  void _groupDetailListVotersResetEvent(
      GroupDetailListVotersResetEvent event, Emitter<GroupDetailListVotersState> emit) {
    emit(GroupDetailListVotersState());
  }
}
