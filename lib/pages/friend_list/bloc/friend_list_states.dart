import 'package:hcmus_alumni_mobile/model/friend.dart';

enum Status { loading, success }

class FriendListState {
  final String name;
  final String nameSearch;

  final Status status;
  final List<Friend> friends;
  final int indexFriend;
  final bool hasReachedMaxFriend;

  final int friendCount;
  final bool isLoading;

  const FriendListState({
    this.name = "",
    this.nameSearch = "",
    this.status = Status.loading,
    this.friends = const [],
    this.indexFriend = 0,
    this.hasReachedMaxFriend = false,
    this.friendCount = 0,
    this.isLoading = false,
  });

  FriendListState copyWith({
    String? name,
    String? nameSearch,
    Status? status,
    List<Friend>? friends,
    int? indexFriend,
    bool? hasReachedMaxFriend,
    int? friendCount,
    bool? isLoading,
  }) {
    return FriendListState(
      name: name ?? this.name,
      nameSearch: nameSearch ?? this.nameSearch,
      status: status ?? this.status,
      friends: friends ?? this.friends,
      indexFriend : indexFriend ?? this.indexFriend,
      hasReachedMaxFriend: hasReachedMaxFriend ?? this.hasReachedMaxFriend,
      friendCount: friendCount ?? this.friendCount,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}