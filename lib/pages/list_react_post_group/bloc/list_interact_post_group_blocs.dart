import 'package:flutter_bloc/flutter_bloc.dart';

import 'list_interact_post_group_events.dart';
import 'list_interact_post_group_states.dart';

class ListInteractPostGroupBloc
    extends Bloc<ListInteractPostGroupEvent, ListInteractPostGroupState> {
  ListInteractPostGroupBloc() : super(ListInteractPostGroupState()) {
    on<StatusInteractEvent>(_statusInteractEvent);
    on<InteractsEvent>(_interactsEvent);
    on<IndexInteractEvent>(_indexInteractEvent);
    on<HasReachedMaxInteractEvent>(_hasReachedMaxInteractEvent);
  }

  void _statusInteractEvent(StatusInteractEvent event,
      Emitter<ListInteractPostGroupState> emit) async {
    emit(state.copyWith(statusInteract: event.statusInteract));
  }

  void _interactsEvent(
      InteractsEvent event, Emitter<ListInteractPostGroupState> emit) async {
    emit(state.copyWith(interacts: event.interacts));
  }

  void _indexInteractEvent(
      IndexInteractEvent event, Emitter<ListInteractPostGroupState> emit) {
    emit(state.copyWith(indexInteract: event.indexInteract));
  }

  void _hasReachedMaxInteractEvent(HasReachedMaxInteractEvent event,
      Emitter<ListInteractPostGroupState> emit) {
    emit(state.copyWith(hasReachedMaxInteract: event.hasReachedMaxInteract));
  }
}
