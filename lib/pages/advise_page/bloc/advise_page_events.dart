import '../../../model/post.dart';
import 'advise_page_states.dart';

class AdvisePageEvent {
  const AdvisePageEvent();
}

class StatusPostEvent extends AdvisePageEvent {
  final Status statusPost;

  const StatusPostEvent(this.statusPost);
}

class PostEvent extends AdvisePageEvent {
  final List<Post> post;

  const PostEvent(this.post);
}

class IndexPostEvent extends AdvisePageEvent {
  final int indexPost;

  const IndexPostEvent(this.indexPost);
}

class HasReachedMaxPostEvent extends AdvisePageEvent {
  final bool hasReachedMaxPost;

  const HasReachedMaxPostEvent(this.hasReachedMaxPost);
}