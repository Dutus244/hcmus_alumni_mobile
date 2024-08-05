abstract class EventDetailWriteCommentEvent {
  const EventDetailWriteCommentEvent();
}

class CommentEvent extends EventDetailWriteCommentEvent {
  final String comment;

  const CommentEvent(this.comment);
}

class IsLoadingEvent extends EventDetailWriteCommentEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class EventDetailWriteCommentResetEvent extends EventDetailWriteCommentEvent {}
