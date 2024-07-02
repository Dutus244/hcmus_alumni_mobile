import 'package:hcmus_alumni_mobile/model/post.dart';

import '../../../model/comment.dart';
import 'post_advise_detail_states.dart';

class PostAdviseDetailEvent {
  const PostAdviseDetailEvent();
}

class PostEvent extends PostAdviseDetailEvent {
  final Post post;

  const PostEvent(this.post);
}

class StatusCommentEvent extends PostAdviseDetailEvent {
  final Status statusComment;

  const StatusCommentEvent(this.statusComment);
}

class CommentsEvent extends PostAdviseDetailEvent {
  final List<Comment> comments;

  const CommentsEvent(this.comments);
}

class IndexCommentEvent extends PostAdviseDetailEvent {
  final int indexComment;

  const IndexCommentEvent(this.indexComment);
}

class HasReachedMaxCommentEvent extends PostAdviseDetailEvent {
  final bool hasReachedMaxComment;

  const HasReachedMaxCommentEvent(this.hasReachedMaxComment);
}

class ContentEvent extends PostAdviseDetailEvent {
  final String content;

  const ContentEvent(this.content);
}

class ChildrenEvent extends PostAdviseDetailEvent {
  final Comment? children;

  const ChildrenEvent(this.children);
}

class ReplyEvent extends PostAdviseDetailEvent {
  final int reply;

  const ReplyEvent(this.reply);
}
