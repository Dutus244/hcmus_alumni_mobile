abstract class EventDetailEditCommentEvent {
  const EventDetailEditCommentEvent();
}

class CommentEvent extends EventDetailEditCommentEvent {
  final String comment;

  const CommentEvent(this.comment);
}

class EventDetailEditCommentResetEvent extends EventDetailEditCommentEvent {}
