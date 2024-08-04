import '../../../model/group.dart';

abstract class GroupManagementEvent {
  const GroupManagementEvent();
}

class GroupEvent extends GroupManagementEvent {
  final Group group;

  const GroupEvent(this.group);
}

class IsLoadingEvent extends GroupManagementEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}