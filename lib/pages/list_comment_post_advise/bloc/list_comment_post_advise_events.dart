import '../../../model/comment.dart';
import 'list_comment_post_advise_states.dart';

class ListCommentPostAdviseEvent {
  const ListCommentPostAdviseEvent();
}

class StatusCommentEvent extends ListCommentPostAdviseEvent {
  final Status statusComment;

  const StatusCommentEvent(this.statusComment);
}

class CommentsEvent extends ListCommentPostAdviseEvent {
  final List<Comment> comments;

  const CommentsEvent(this.comments);
}

class IndexCommentEvent extends ListCommentPostAdviseEvent {
  final int indexComment;

  const IndexCommentEvent(this.indexComment);
}

class HasReachedMaxCommentEvent extends ListCommentPostAdviseEvent {
  final bool hasReachedMaxComment;

  const HasReachedMaxCommentEvent(this.hasReachedMaxComment);
}

class ContentEvent extends ListCommentPostAdviseEvent {
  final String content;

  const ContentEvent(this.content);
}

class ChildrenEvent extends ListCommentPostAdviseEvent {
  final Comment? children;

  const ChildrenEvent(this.children);
}

class IsLoadingEvent extends ListCommentPostAdviseEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class ReplyEvent extends ListCommentPostAdviseEvent {
  final int reply;

  const ReplyEvent(this.reply);
}
