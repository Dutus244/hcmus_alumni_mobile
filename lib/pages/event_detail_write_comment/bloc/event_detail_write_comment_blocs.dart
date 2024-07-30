import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_detail_write_comment_events.dart';
import 'event_detail_write_comment_states.dart';

class EventDetailWriteCommentBloc
    extends Bloc<EventDetailWriteCommentEvent, EventDetailWriteCommentState> {
  EventDetailWriteCommentBloc() : super(EventDetailWriteCommentState()) {
    on<CommentEvent>(_commentEvent);
    ;
    on<EventDetailWriteCommentResetEvent>(_newsDetailWriteCommentResetEvent);
  }

  void _commentEvent(
      CommentEvent event, Emitter<EventDetailWriteCommentState> emit) {
    emit(state.copyWith(comment: event.comment));
  }

  void _newsDetailWriteCommentResetEvent(
      EventDetailWriteCommentResetEvent event,
      Emitter<EventDetailWriteCommentState> emit) {
    emit(
        EventDetailWriteCommentState()); // Reset the state to its initial state
  }
}
