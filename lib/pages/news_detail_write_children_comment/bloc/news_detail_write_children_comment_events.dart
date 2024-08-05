abstract class NewsDetailWriteChildrenCommentEvent {
  const NewsDetailWriteChildrenCommentEvent();
}

class CommentEvent extends NewsDetailWriteChildrenCommentEvent {
  final String comment;

  const CommentEvent(this.comment);
}

class IsLoadingEvent extends NewsDetailWriteChildrenCommentEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class NewsDetailWriteChildrenCommentResetEvent
    extends NewsDetailWriteChildrenCommentEvent {}
