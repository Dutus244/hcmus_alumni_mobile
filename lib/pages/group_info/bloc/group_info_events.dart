import '../../../model/member.dart';
import 'group_info_states.dart';

class GroupInfoEvent {
  const GroupInfoEvent();
}

class MemberEvent extends GroupInfoEvent {
  final List<Member> member;

  const MemberEvent(this.member);
}

class AdminEvent extends GroupInfoEvent {
  final List<Member> admin;

  const AdminEvent(this.admin);
}