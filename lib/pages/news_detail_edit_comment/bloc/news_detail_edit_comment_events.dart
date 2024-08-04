abstract class NewsDetailEditCommentEvent {
  const NewsDetailEditCommentEvent();
}

class CommentEvent extends NewsDetailEditCommentEvent {
  final String comment;

  const CommentEvent(this.comment);
}

class IsLoadingEvent extends NewsDetailEditCommentEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class NewsDetailEditCommentResetEvent extends NewsDetailEditCommentEvent {}
