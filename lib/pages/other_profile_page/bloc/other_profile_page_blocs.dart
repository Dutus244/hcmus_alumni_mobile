import 'package:flutter_bloc/flutter_bloc.dart';

import 'other_profile_page_events.dart';
import 'other_profile_page_states.dart';

class OtherProfilePageBloc extends Bloc<OtherProfilePageEvent, OtherProfilePageState> {
  OtherProfilePageBloc() : super(OtherProfilePageState()) {
    on<StatusEventEvent>(_statusEventEvent);
    on<EventsEvent>(_eventsEvent);
    on<IndexEventEvent>(_indexEventEvent);
    on<HasReachedMaxEventEvent>(_hasReachedMaxEventEvent);
  }

  void _statusEventEvent(
      StatusEventEvent event, Emitter<OtherProfilePageState> emit) async {
    emit(state.copyWith(statusEvent: event.statusEvent));
  }

  void _eventsEvent(EventsEvent event, Emitter<OtherProfilePageState> emit) async {
    emit(state.copyWith(events: event.events));
  }

  void _indexEventEvent(
      IndexEventEvent event, Emitter<OtherProfilePageState> emit) {
    emit(state.copyWith(indexEvent: event.indexEvent));
  }

  void _hasReachedMaxEventEvent(
      HasReachedMaxEventEvent event, Emitter<OtherProfilePageState> emit) {
    emit(state.copyWith(hasReachedMaxEvent: event.hasReachedMaxEvent));
  }
}