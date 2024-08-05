import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_detail_write_children_comment_events.dart';
import 'event_detail_write_children_comment_states.dart';

class EventDetailWriteChildrenCommentBloc extends Bloc<
    EventDetailWriteChildrenCommentEvent,
    EventDetailWriteChildrenCommentState> {
  EventDetailWriteChildrenCommentBloc()
      : super(EventDetailWriteChildrenCommentState()) {
    on<CommentEvent>(_commentEvent);
    on<IsLoadingEvent>(_isLoadingEvent);
    on<EventDetailWriteChildrenCommentResetEvent>(
        _eventDetailWriteChildrenCommentResetEvent);
  }

  void _commentEvent(
      CommentEvent event, Emitter<EventDetailWriteChildrenCommentState> emit) {
    emit(state.copyWith(comment: event.comment));
  }

  void _isLoadingEvent(IsLoadingEvent event,
      Emitter<EventDetailWriteChildrenCommentState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _eventDetailWriteChildrenCommentResetEvent(
      EventDetailWriteChildrenCommentResetEvent event,
      Emitter<EventDetailWriteChildrenCommentState> emit) {
    emit(
        EventDetailWriteChildrenCommentState()); // Reset the state to its initial state
  }
}
