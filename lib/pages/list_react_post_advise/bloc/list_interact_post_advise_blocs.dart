import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_interact_post_advise_events.dart';
import 'list_interact_post_advise_states.dart';

class ListInteractPostAdviseBloc
    extends Bloc<ListInteractPostAdviseEvent, ListInteractPostAdviseState> {
  ListInteractPostAdviseBloc() : super(ListInteractPostAdviseState()) {
    on<StatusInteractEvent>(_statusInteractEvent);
    on<InteractEvent>(_interactEvent);
    on<IndexInteractEvent>(_indexInteractEvent);
    on<HasReachedMaxInteractEvent>(_hasReachedMaxInteractEvent);
  }

  void _statusInteractEvent(StatusInteractEvent event,
      Emitter<ListInteractPostAdviseState> emit) async {
    emit(state.copyWith(statusInteract: event.statusInteract));
  }

  void _interactEvent(
      InteractEvent event, Emitter<ListInteractPostAdviseState> emit) async {
    emit(state.copyWith(interact: event.interact));
  }

  void _indexInteractEvent(
      IndexInteractEvent event, Emitter<ListInteractPostAdviseState> emit) {
    emit(state.copyWith(indexInteract: event.indexInteract));
  }

  void _hasReachedMaxInteractEvent(HasReachedMaxInteractEvent event,
      Emitter<ListInteractPostAdviseState> emit) {
    emit(state.copyWith(hasReachedMaxInteract: event.hasReachedMaxInteract));
  }
}
