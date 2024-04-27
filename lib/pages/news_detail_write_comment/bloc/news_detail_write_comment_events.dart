abstract class NewsDetailWriteCommentEvent {
  const NewsDetailWriteCommentEvent();
}

class CommentEvent extends NewsDetailWriteCommentEvent {
  final String comment;

  const CommentEvent(this.comment);
}

class NewsDetailWriteCommentResetEvent extends NewsDetailWriteCommentEvent {}
