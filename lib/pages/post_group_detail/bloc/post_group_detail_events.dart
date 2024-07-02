import 'package:hcmus_alumni_mobile/model/post.dart';

import '../../../model/comment.dart';
import 'post_group_detail_states.dart';

class PostGroupDetailEvent {
  const PostGroupDetailEvent();
}

class PostEvent extends PostGroupDetailEvent {
  final Post post;

  const PostEvent(this.post);
}

class StatusCommentEvent extends PostGroupDetailEvent {
  final Status statusComment;

  const StatusCommentEvent(this.statusComment);
}

class CommentsEvent extends PostGroupDetailEvent {
  final List<Comment> comments;

  const CommentsEvent(this.comments);
}

class IndexCommentEvent extends PostGroupDetailEvent {
  final int indexComment;

  const IndexCommentEvent(this.indexComment);
}

class HasReachedMaxCommentEvent extends PostGroupDetailEvent {
  final bool hasReachedMaxComment;

  const HasReachedMaxCommentEvent(this.hasReachedMaxComment);
}

class ContentEvent extends PostGroupDetailEvent {
  final String content;

  const ContentEvent(this.content);
}

class ChildrenEvent extends PostGroupDetailEvent {
  final Comment? children;

  const ChildrenEvent(this.children);
}

class ReplyEvent extends PostGroupDetailEvent {
  final int reply;

  const ReplyEvent(this.reply);
}
