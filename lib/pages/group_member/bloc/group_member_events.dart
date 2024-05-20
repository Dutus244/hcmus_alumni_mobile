import '../../../model/member.dart';
import 'group_member_states.dart';

class GroupMemberEvent {
  const GroupMemberEvent();
}

class StatusEvent extends GroupMemberEvent {
  final Status status;

  const StatusEvent(this.status);
}

class MemberEvent extends GroupMemberEvent {
  final List<Member> member;

  const MemberEvent(this.member);
}

class IndexMemberEvent extends GroupMemberEvent {
  final int indexMember;

  const IndexMemberEvent(this.indexMember);
}

class HasReachedMaxMemberEvent extends GroupMemberEvent {
  final bool hasReachedMaxMember;

  const HasReachedMaxMemberEvent(this.hasReachedMaxMember);
}

class AdminEvent extends GroupMemberEvent {
  final List<Member> admin;

  const AdminEvent(this.admin);
}

class IndexAdminEvent extends GroupMemberEvent {
  final int indexAdmin;

  const IndexAdminEvent(this.indexAdmin);
}

class HasReachedMaxAdminEvent extends GroupMemberEvent {
  final bool hasReachedMaxAdmin;

  const HasReachedMaxAdminEvent(this.hasReachedMaxAdmin);
}