import 'package:hcmus_alumni_mobile/model/friend_request.dart';
import 'package:hcmus_alumni_mobile/model/friend_suggestion.dart';
import 'package:hcmus_alumni_mobile/model/notification.dart';

import 'friend_page_states.dart';

class FriendPageEvent {
  const FriendPageEvent();
}

class PageEvent extends FriendPageEvent {
  final int page;

  const PageEvent(this.page);
}
class NameEvent extends FriendPageEvent {
  final String name;

  const NameEvent(this.name);
}

class NameSearchEvent extends FriendPageEvent {
  final String nameSearch;

  const NameSearchEvent(this.nameSearch);
}


class StatusSuggestionEvent extends FriendPageEvent {
  final Status statusSuggestion;

  const StatusSuggestionEvent(this.statusSuggestion);
}

class FriendSuggestionsEvent extends FriendPageEvent {
  final List<FriendSuggestion> friendSuggestions;

  const FriendSuggestionsEvent(this.friendSuggestions);
}

class IndexSuggestionEvent extends FriendPageEvent {
  final int indexSuggestion;

  const IndexSuggestionEvent(this.indexSuggestion);
}

class HasReachedMaxSuggestionEvent extends FriendPageEvent {
  final bool hasReachedMaxSuggestion;

  const HasReachedMaxSuggestionEvent(this.hasReachedMaxSuggestion);
}

class StatusRequestEvent extends FriendPageEvent {
  final Status statusRequest;

  const StatusRequestEvent(this.statusRequest);
}

class FriendRequestsEvent extends FriendPageEvent {
  final List<FriendRequest> friendRequests;

  const FriendRequestsEvent(this.friendRequests);
}

class IndexRequestEvent extends FriendPageEvent {
  final int indexRequest;

  const IndexRequestEvent(this.indexRequest);
}

class HasReachedMaxRequestEvent extends FriendPageEvent {
  final bool hasReachedMaxRequest;

  const HasReachedMaxRequestEvent(this.hasReachedMaxRequest);
}