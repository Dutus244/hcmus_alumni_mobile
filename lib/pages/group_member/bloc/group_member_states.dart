import 'package:hcmus_alumni_mobile/model/member.dart';

enum Status { loading, success }

class GroupMemberState {
  final Status status;

  final List<Member> member;
  final int indexMember;
  final bool hasReachedMaxMember;

  final List<Member> admin;
  final int indexAdmin;
  final bool hasReachedMaxAdmin;

  GroupMemberState(
      {
        this.status = Status.loading,
        this.member = const [],
        this.indexMember = 0,
        this.hasReachedMaxMember = false,
        this.admin = const [],
        this.indexAdmin = 0,
        this.hasReachedMaxAdmin = false});

  GroupMemberState copyWith(
      {Status? status,
        List<Member>? member,
        int? indexMember,
        bool? hasReachedMaxMember,
        List<Member>? admin,
        int? indexAdmin,
        bool? hasReachedMaxAdmin}) {
    return GroupMemberState(
      status: status ?? this.status,
      member: member ?? this.member,
      indexMember: indexMember ?? this.indexMember,
      hasReachedMaxMember:
      hasReachedMaxMember ?? this.hasReachedMaxMember,
      indexAdmin: indexAdmin ?? this.indexAdmin,
      admin: admin ?? this.admin,
      hasReachedMaxAdmin:
      hasReachedMaxAdmin ?? this.hasReachedMaxAdmin,
    );
  }
}