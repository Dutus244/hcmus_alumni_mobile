import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_detail_events.dart';
import 'event_detail_states.dart';

class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  EventDetailBloc() : super(EventDetailState()) {
    on<PageEvent>(_pageEvent);
    on<RelatedEventEvent>(_relatedEventEvent);
  }

  void _pageEvent(PageEvent event, Emitter<EventDetailState> emit) {
    emit(state.copyWith(page: event.page));
  }

  void _relatedEventEvent(RelatedEventEvent event, Emitter<EventDetailState> emit) {
    emit(state.copyWith(relatedEvent: event.relatedEvent));
  }
}
