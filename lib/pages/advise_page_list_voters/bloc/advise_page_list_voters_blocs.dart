import 'package:flutter_bloc/flutter_bloc.dart';

import 'advise_page_list_voters_events.dart';
import 'advise_page_list_voters_states.dart';

class AdvisePageListVotersBloc extends Bloc<AdvisePageListVotersEvent, AdvisePageListVotersState> {
  AdvisePageListVotersBloc() : super(AdvisePageListVotersState()) {
    on<StatusVoterEvent>(_statusVoterEvent);
    on<VotersEvent>(_votersEvent);
    on<IndexVoterEvent>(_indexVoterEvent);
    on<HasReachedMaxVoterEvent>(_hasReachedMaxVoterEvent);
    on<AdvisePageListVotersResetEvent>(_advisePageListVotersResetEvent);
  }

  void _statusVoterEvent(
      StatusVoterEvent event, Emitter<AdvisePageListVotersState> emit) async {
    emit(state.copyWith(statusVoter: event.statusVoter));
  }

  void _votersEvent(VotersEvent event, Emitter<AdvisePageListVotersState> emit) async {
    emit(state.copyWith(voters: event.voters));
  }

  void _indexVoterEvent(IndexVoterEvent event, Emitter<AdvisePageListVotersState> emit) {
    emit(state.copyWith(indexVoter: event.indexVoter));
  }

  void _hasReachedMaxVoterEvent(
      HasReachedMaxVoterEvent event, Emitter<AdvisePageListVotersState> emit) {
    emit(state.copyWith(hasReachedMaxVoter: event.hasReachedMaxVoter));
  }

  void _advisePageListVotersResetEvent(
      AdvisePageListVotersResetEvent event, Emitter<AdvisePageListVotersState> emit) {
    emit(AdvisePageListVotersState());
  }
}
