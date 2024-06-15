import 'package:hcmus_alumni_mobile/model/friend_suggestion.dart';
import 'package:hcmus_alumni_mobile/model/friend_request.dart';

enum Status { loading, success }

class FriendPageState {
  final int page;
  final String name;
  final String nameSearch;

  final Status statusSuggestion;
  final List<FriendSuggestion> friendSuggestions;
  final int indexSuggestion;
  final bool hasReachedMaxSuggestion;

  final Status statusRequest;
  final List<FriendRequest> friendRequests;
  final int indexRequest;
  final bool hasReachedMaxRequest;

  FriendPageState({
    this.page = 0,
    this.name = "",
    this.nameSearch = "",
    this.statusSuggestion = Status.loading,
    this.friendSuggestions = const [],
    this.indexSuggestion = 0,
    this.hasReachedMaxSuggestion = false,
    this.statusRequest = Status.loading,
    this.friendRequests = const [],
    this.indexRequest = 0,
    this.hasReachedMaxRequest = false,
  });

  FriendPageState copyWith({
    int? page,
    String? name,
    String? nameSearch,
    Status? statusSuggestion,
    List<FriendSuggestion>? friendSuggestions,
    int? indexSuggestion,
    bool? hasReachedMaxSuggestion,
    Status? statusRequest,
    List<FriendRequest>? friendRequests,
    int? indexRequest,
    bool? hasReachedMaxRequest,
  }) {
    return FriendPageState(
        page: page ?? this.page,
        name: name ?? this.name,
        nameSearch: nameSearch ?? this.nameSearch,
        statusSuggestion: statusSuggestion ?? this.statusSuggestion,
        friendSuggestions: friendSuggestions ?? this.friendSuggestions,
        indexSuggestion: indexSuggestion ?? this.indexSuggestion,
        hasReachedMaxSuggestion:
            hasReachedMaxSuggestion ?? this.hasReachedMaxSuggestion,
        statusRequest: statusRequest ?? this.statusRequest,
        friendRequests: friendRequests ?? this.friendRequests,
        indexRequest: indexRequest ?? this.indexRequest,
        hasReachedMaxRequest:
            hasReachedMaxRequest ?? this.hasReachedMaxRequest);
  }
}
