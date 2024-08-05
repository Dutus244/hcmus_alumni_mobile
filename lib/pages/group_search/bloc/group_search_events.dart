import 'package:hcmus_alumni_mobile/model/group.dart';

import 'group_search_states.dart';

abstract class GroupSearchEvent {
  const GroupSearchEvent();
}

class NameEvent extends GroupSearchEvent {
  final String name;

  const NameEvent(this.name);
}

class NameSearchEvent extends GroupSearchEvent {
  final String nameSearch;

  const NameSearchEvent(this.nameSearch);
}

class StatusEvent extends GroupSearchEvent {
  final Status status;

  const StatusEvent(this.status);
}

class GroupsEvent extends GroupSearchEvent {
  final List<Group> groups;

  const GroupsEvent(this.groups);
}

class IndexGroupEvent extends GroupSearchEvent {
  final int indexGroup;

  const IndexGroupEvent(this.indexGroup);
}

class HasReachedMaxGroupEvent extends GroupSearchEvent {
  final bool hasReachedMaxGroup;

  const HasReachedMaxGroupEvent(this.hasReachedMaxGroup);
}

class IsLoadingEvent extends GroupSearchEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class ClearResultEvent extends GroupSearchEvent {}

class GroupSearchResetEvent extends GroupSearchEvent {}