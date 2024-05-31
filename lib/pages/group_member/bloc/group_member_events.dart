import '../../../model/member.dart';
import 'group_member_states.dart';

class GroupMemberEvent {
  const GroupMemberEvent();
}

class StatusEvent extends GroupMemberEvent {
  final Status status;

  const StatusEvent(this.status);
}

class MembersEvent extends GroupMemberEvent {
  final List<Member> members;

  const MembersEvent(this.members);
}

class IndexMemberEvent extends GroupMemberEvent {
  final int indexMember;

  const IndexMemberEvent(this.indexMember);
}

class HasReachedMaxMemberEvent extends GroupMemberEvent {
  final bool hasReachedMaxMember;

  const HasReachedMaxMemberEvent(this.hasReachedMaxMember);
}

class AdminsEvent extends GroupMemberEvent {
  final List<Member> admins;

  const AdminsEvent(this.admins);
}

class IndexAdminEvent extends GroupMemberEvent {
  final int indexAdmin;

  const IndexAdminEvent(this.indexAdmin);
}

class HasReachedMaxAdminEvent extends GroupMemberEvent {
  final bool hasReachedMaxAdmin;

  const HasReachedMaxAdminEvent(this.hasReachedMaxAdmin);
}