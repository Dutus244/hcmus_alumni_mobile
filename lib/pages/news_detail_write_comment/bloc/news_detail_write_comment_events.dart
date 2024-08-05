abstract class NewsDetailWriteCommentEvent {
  const NewsDetailWriteCommentEvent();
}

class CommentEvent extends NewsDetailWriteCommentEvent {
  final String comment;

  const CommentEvent(this.comment);
}

class IsLoadingEvent extends NewsDetailWriteCommentEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class NewsDetailWriteCommentResetEvent extends NewsDetailWriteCommentEvent {}
