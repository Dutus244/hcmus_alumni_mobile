import 'package:hcmus_alumni_mobile/model/group.dart';

enum Status { loading, success }

class GroupSearchState {
  final String name;
  final String nameSearch;

  final Status status;
  final List<Group> groups;
  final int indexGroup;
  final bool hasReachedMaxGroup;

  final bool isLoading;

  const GroupSearchState({
    this.name = "",
    this.nameSearch = "",
    this.status = Status.loading,
    this.groups = const [],
    this.indexGroup = 0,
    this.hasReachedMaxGroup = false,
    this.isLoading = false,
  });

  GroupSearchState copyWith({
    String? name,
    String? nameSearch,
    Status? status,
    List<Group>? groups,
    int? indexGroup,
    bool? hasReachedMaxGroup,
    bool? isLoading,
  }) {
    return GroupSearchState(
      name: name ?? this.name,
      nameSearch: nameSearch ?? this.nameSearch,
      status: status ?? this.status,
      groups: groups ?? this.groups,
      indexGroup : indexGroup ?? this.indexGroup,
      hasReachedMaxGroup: hasReachedMaxGroup ?? this.hasReachedMaxGroup,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}