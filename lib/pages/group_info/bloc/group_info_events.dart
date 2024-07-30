import '../../../model/member.dart';
import 'group_info_states.dart';

class GroupInfoEvent {
  const GroupInfoEvent();
}

class MembersEvent extends GroupInfoEvent {
  final List<Member> members;

  const MembersEvent(this.members);
}

class AdminsEvent extends GroupInfoEvent {
  final List<Member> admins;

  const AdminsEvent(this.admins);
}