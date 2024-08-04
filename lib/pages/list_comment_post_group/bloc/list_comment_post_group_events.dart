import '../../../model/comment.dart';
import 'list_comment_post_group_states.dart';

class ListCommentPostGroupEvent {
  const ListCommentPostGroupEvent();
}

class StatusCommentEvent extends ListCommentPostGroupEvent {
  final Status statusComment;

  const StatusCommentEvent(this.statusComment);
}

class CommentsEvent extends ListCommentPostGroupEvent {
  final List<Comment> comments;

  const CommentsEvent(this.comments);
}

class IndexCommentEvent extends ListCommentPostGroupEvent {
  final int indexComment;

  const IndexCommentEvent(this.indexComment);
}

class HasReachedMaxCommentEvent extends ListCommentPostGroupEvent {
  final bool hasReachedMaxComment;

  const HasReachedMaxCommentEvent(this.hasReachedMaxComment);
}

class ContentEvent extends ListCommentPostGroupEvent {
  final String content;

  const ContentEvent(this.content);
}

class ChildrenEvent extends ListCommentPostGroupEvent {
  final Comment? children;

  const ChildrenEvent(this.children);
}

class ReplyEvent extends ListCommentPostGroupEvent {
  final int reply;

  const ReplyEvent(this.reply);
}

class IsLoadingEvent extends ListCommentPostGroupEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}
