import '../../../model/group.dart';
import 'group_page_states.dart';

class GroupPageEvent {
  const GroupPageEvent();
}

class PageEvent extends GroupPageEvent {
  final int page;

  const PageEvent(this.page);
}

class StatusGroupDiscoverEvent extends GroupPageEvent {
  final Status statusGroupDiscover;

  const StatusGroupDiscoverEvent(this.statusGroupDiscover);
}

class GroupDiscoversEvent extends GroupPageEvent {
  final List<Group> groupDiscovers;

  const GroupDiscoversEvent(this.groupDiscovers);
}

class IndexGroupDiscoverEvent extends GroupPageEvent {
  final int indexGroupDiscover;

  const IndexGroupDiscoverEvent(this.indexGroupDiscover);
}

class HasReachedMaxGroupDiscoverEvent extends GroupPageEvent {
  final bool hasReachedMaxGroupDiscover;

  const HasReachedMaxGroupDiscoverEvent(this.hasReachedMaxGroupDiscover);
}

class StatusGroupJoinedEvent extends GroupPageEvent {
  final Status statusGroupJoined;

  const StatusGroupJoinedEvent(this.statusGroupJoined);
}

class GroupJoinedsEvent extends GroupPageEvent {
  final List<Group> groupJoineds;

  const GroupJoinedsEvent(this.groupJoineds);
}

class IndexGroupJoinedEvent extends GroupPageEvent {
  final int indexGroupJoined;

  const IndexGroupJoinedEvent(this.indexGroupJoined);
}

class HasReachedMaxGroupJoinedEvent extends GroupPageEvent {
  final bool hasReachedMaxGroupJoined;

  const HasReachedMaxGroupJoinedEvent(this.hasReachedMaxGroupJoined);
}

class IsLoadingEvent extends GroupPageEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}
