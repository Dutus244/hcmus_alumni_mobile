abstract class NewsDetailEditCommentEvent {
  const NewsDetailEditCommentEvent();
}

class CommentEvent extends NewsDetailEditCommentEvent {
  final String comment;

  const CommentEvent(this.comment);
}

class NewsDetailEditCommentResetEvent extends NewsDetailEditCommentEvent {}
