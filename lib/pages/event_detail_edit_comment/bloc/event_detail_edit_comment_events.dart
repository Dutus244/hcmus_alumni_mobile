abstract class EventDetailEditCommentEvent {
  const EventDetailEditCommentEvent();
}

class CommentEvent extends EventDetailEditCommentEvent {
  final String comment;

  const CommentEvent(this.comment);
}

class IsLoadingEvent extends EventDetailEditCommentEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class EventDetailEditCommentResetEvent extends EventDetailEditCommentEvent {}
