abstract class EventDetailWriteChildrenCommentEvent {
  const EventDetailWriteChildrenCommentEvent();
}

class CommentEvent extends EventDetailWriteChildrenCommentEvent {
  final String comment;

  const CommentEvent(this.comment);
}

class EventDetailWriteChildrenCommentResetEvent
    extends EventDetailWriteChildrenCommentEvent {}
