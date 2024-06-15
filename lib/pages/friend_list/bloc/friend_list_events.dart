import 'package:hcmus_alumni_mobile/model/friend.dart';
import 'package:hcmus_alumni_mobile/model/group.dart';

import 'friend_list_states.dart';

abstract class FriendListEvent {
  const FriendListEvent();
}

class NameEvent extends FriendListEvent {
  final String name;

  const NameEvent(this.name);
}

class NameSearchEvent extends FriendListEvent {
  final String nameSearch;

  const NameSearchEvent(this.nameSearch);
}

class StatusEvent extends FriendListEvent {
  final Status status;

  const StatusEvent(this.status);
}

class FriendsEvent extends FriendListEvent {
  final List<Friend> friends;

  const FriendsEvent(this.friends);
}

class IndexFriendEvent extends FriendListEvent {
  final int indexGroup;

  const IndexFriendEvent(this.indexGroup);
}

class HasReachedMaxFriendEvent extends FriendListEvent {
  final bool hasReachedMaxGroup;

  const HasReachedMaxFriendEvent(this.hasReachedMaxGroup);
}

class ClearResultEvent extends FriendListEvent {}

class FriendSearchResetEvent extends FriendListEvent {}