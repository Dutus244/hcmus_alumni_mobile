import '../../../model/group.dart';
import '../../../model/post.dart';
import 'group_detail_states.dart';

class GroupDetailEvent {
  const GroupDetailEvent();
}

class GroupEvent extends GroupDetailEvent {
  final Group group;

  const GroupEvent(this.group);
}

class StatusPostEvent extends GroupDetailEvent {
  final Status statusPost;

  const StatusPostEvent(this.statusPost);
}

class PostEvent extends GroupDetailEvent {
  final List<Post> post;

  const PostEvent(this.post);
}

class IndexPostEvent extends GroupDetailEvent {
  final int indexPost;

  const IndexPostEvent(this.indexPost);
}

class HasReachedMaxPostEvent extends GroupDetailEvent {
  final bool hasReachedMaxPost;

  const HasReachedMaxPostEvent(this.hasReachedMaxPost);
}