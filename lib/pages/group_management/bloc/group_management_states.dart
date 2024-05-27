import '../../../model/group.dart';

class GroupManagementState {
  final Group? group;

  GroupManagementState({this.group = null});

  GroupManagementState copyWith({Group? group}) {
    return GroupManagementState(group: group ?? this.group);
  }
}
