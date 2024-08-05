abstract class EventDetailWriteChildrenCommentEvent {
  const EventDetailWriteChildrenCommentEvent();
}

class CommentEvent extends EventDetailWriteChildrenCommentEvent {
  final String comment;

  const CommentEvent(this.comment);
}

class IsLoadingEvent extends EventDetailWriteChildrenCommentEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class EventDetailWriteChildrenCommentResetEvent
    extends EventDetailWriteChildrenCommentEvent {}
