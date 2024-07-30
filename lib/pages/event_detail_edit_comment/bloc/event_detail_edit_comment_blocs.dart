import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_detail_edit_comment_events.dart';
import 'event_detail_edit_comment_states.dart';

class EventDetailEditCommentBloc
    extends Bloc<EventDetailEditCommentEvent, EventDetailEditCommentState> {
  EventDetailEditCommentBloc() : super(EventDetailEditCommentState()) {
    on<CommentEvent>(_commentEvent);
    on<EventDetailEditCommentResetEvent>(_eventDetailEditCommentResetEvent);
  }

  void _commentEvent(
      CommentEvent event, Emitter<EventDetailEditCommentState> emit) {
    emit(state.copyWith(comment: event.comment));
  }

  void _eventDetailEditCommentResetEvent(EventDetailEditCommentResetEvent event,
      Emitter<EventDetailEditCommentState> emit) {
    emit(EventDetailEditCommentState()); // Reset the state to its initial state
  }
}
