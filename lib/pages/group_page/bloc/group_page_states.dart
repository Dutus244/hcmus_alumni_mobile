import '../../../model/group.dart';

enum Status { loading, success }

class GroupPageState {
  final int page;

  final Status statusGroupDiscover;
  final List<Group> groupDiscover;
  final int indexGroupDiscover;
  final bool hasReachedMaxGroupDiscover;

  final Status statusGroupJoined;
  final List<Group> groupJoined;
  final int indexGroupJoined;
  final bool hasReachedMaxGroupJoined;

  GroupPageState({
    this.page = 0,
    this.statusGroupDiscover = Status.loading,
    this.groupDiscover = const [],
    this.indexGroupDiscover = 0,
    this.hasReachedMaxGroupDiscover = false,
    this.statusGroupJoined = Status.loading,
    this.groupJoined = const [],
    this.indexGroupJoined = 0,
    this.hasReachedMaxGroupJoined = false,
  });

  GroupPageState copyWith({
    int? page,
    Status? statusGroupDiscover,
    List<Group>? groupDiscover,
    int? indexGroupDiscover,
    bool? hasReachedMaxGroupDiscover,
    Status? statusGroupJoined,
    List<Group>? groupJoined,
    int? indexGroupJoined,
    bool? hasReachedMaxGroupJoined,
  }) {
    return GroupPageState(
      page: page ?? this.page,
      statusGroupDiscover: statusGroupDiscover ?? this.statusGroupDiscover,
      groupDiscover: groupDiscover ?? this.groupDiscover,
      indexGroupDiscover: indexGroupDiscover ?? this.indexGroupDiscover,
      hasReachedMaxGroupDiscover:
          hasReachedMaxGroupDiscover ?? this.hasReachedMaxGroupDiscover,
      statusGroupJoined: statusGroupJoined ?? this.statusGroupJoined,
      groupJoined: groupJoined ?? this.groupJoined,
      indexGroupJoined: indexGroupJoined ?? this.indexGroupJoined,
      hasReachedMaxGroupJoined:
          hasReachedMaxGroupJoined ?? this.hasReachedMaxGroupJoined,
    );
  }
}
