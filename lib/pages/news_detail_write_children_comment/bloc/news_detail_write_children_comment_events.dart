abstract class NewsDetailWriteChildrenCommentEvent {
  const NewsDetailWriteChildrenCommentEvent();
}

class CommentEvent extends NewsDetailWriteChildrenCommentEvent {
  final String comment;

  const CommentEvent(this.comment);
}

class NewsDetailWriteChildrenCommentResetEvent
    extends NewsDetailWriteChildrenCommentEvent {}
