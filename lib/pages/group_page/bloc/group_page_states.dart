import '../../../model/group.dart';

enum Status { loading, success }

class GroupPageState {
  final int page;

  final Status statusGroupDiscover;
  final List<Group> groupDiscovers;
  final int indexGroupDiscover;
  final bool hasReachedMaxGroupDiscover;

  final Status statusGroupJoined;
  final List<Group> groupJoineds;
  final int indexGroupJoined;
  final bool hasReachedMaxGroupJoined;

  final bool isLoading;

  GroupPageState({
    this.page = 0,
    this.statusGroupDiscover = Status.loading,
    this.groupDiscovers = const [],
    this.indexGroupDiscover = 0,
    this.hasReachedMaxGroupDiscover = false,
    this.statusGroupJoined = Status.loading,
    this.groupJoineds = const [],
    this.indexGroupJoined = 0,
    this.hasReachedMaxGroupJoined = false,
    this.isLoading = false,
  });

  GroupPageState copyWith({
    int? page,
    Status? statusGroupDiscover,
    List<Group>? groupDiscovers,
    int? indexGroupDiscover,
    bool? hasReachedMaxGroupDiscover,
    Status? statusGroupJoined,
    List<Group>? groupJoineds,
    int? indexGroupJoined,
    bool? hasReachedMaxGroupJoined,
    bool? isLoading,
  }) {
    return GroupPageState(
      page: page ?? this.page,
      statusGroupDiscover: statusGroupDiscover ?? this.statusGroupDiscover,
      groupDiscovers: groupDiscovers ?? this.groupDiscovers,
      indexGroupDiscover: indexGroupDiscover ?? this.indexGroupDiscover,
      hasReachedMaxGroupDiscover:
          hasReachedMaxGroupDiscover ?? this.hasReachedMaxGroupDiscover,
      statusGroupJoined: statusGroupJoined ?? this.statusGroupJoined,
      groupJoineds: groupJoineds ?? this.groupJoineds,
      indexGroupJoined: indexGroupJoined ?? this.indexGroupJoined,
      hasReachedMaxGroupJoined:
          hasReachedMaxGroupJoined ?? this.hasReachedMaxGroupJoined,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
