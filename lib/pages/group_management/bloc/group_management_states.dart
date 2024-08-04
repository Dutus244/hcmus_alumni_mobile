import '../../../model/group.dart';

class GroupManagementState {
  final Group? group;
  final bool isLoading;

  GroupManagementState({this.group = null, this.isLoading = false});

  GroupManagementState copyWith({Group? group, bool? isLoading}) {
    return GroupManagementState(
        group: group ?? this.group, isLoading: isLoading ?? this.isLoading);
  }
}
