abstract class EventDetailWriteCommentEvent {
  const EventDetailWriteCommentEvent();
}

class CommentEvent extends EventDetailWriteCommentEvent {
  final String comment;

  const CommentEvent(this.comment);
}

class EventDetailWriteCommentResetEvent extends EventDetailWriteCommentEvent {}
