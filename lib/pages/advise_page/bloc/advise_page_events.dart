import '../../../model/post.dart';
import '../../../model/voter.dart';
import 'advise_page_states.dart';

class AdvisePageEvent {
  const AdvisePageEvent();
}

class StatusPostEvent extends AdvisePageEvent {
  final Status statusPost;

  const StatusPostEvent(this.statusPost);
}

class PostsEvent extends AdvisePageEvent {
  final List<Post> posts;

  const PostsEvent(this.posts);
}

class IndexPostEvent extends AdvisePageEvent {
  final int indexPost;

  const IndexPostEvent(this.indexPost);
}

class HasReachedMaxPostEvent extends AdvisePageEvent {
  final bool hasReachedMaxPost;

  const HasReachedMaxPostEvent(this.hasReachedMaxPost);
}

class StatusVoterEvent extends AdvisePageEvent {
  final Status statusVoter;

  const StatusVoterEvent(this.statusVoter);
}

class VotersEvent extends AdvisePageEvent {
  final List<Voter> voters;

  const VotersEvent(this.voters);
}

class IndexVoterEvent extends AdvisePageEvent {
  final int indexVoter;

  const IndexVoterEvent(this.indexVoter);
}

class HasReachedMaxVoterEvent extends AdvisePageEvent {
  final bool hasReachedMaxVoter;

  const HasReachedMaxVoterEvent(this.hasReachedMaxVoter);
}

class IsLoadingEvent extends AdvisePageEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class IsLoadingEvent extends AdvisePageEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}
