import 'package:hcmus_alumni_mobile/model/member.dart';

enum Status { loading, success }

class GroupMemberState {
  final Status status;

  final List<Member> members;
  final int indexMember;
  final bool hasReachedMaxMember;

  final List<Member> admins;
  final int indexAdmin;
  final bool hasReachedMaxAdmin;

  GroupMemberState(
      {
        this.status = Status.loading,
        this.members = const [],
        this.indexMember = 0,
        this.hasReachedMaxMember = false,
        this.admins = const [],
        this.indexAdmin = 0,
        this.hasReachedMaxAdmin = false});

  GroupMemberState copyWith(
      {Status? status,
        List<Member>? members,
        int? indexMember,
        bool? hasReachedMaxMember,
        List<Member>? admins,
        int? indexAdmin,
        bool? hasReachedMaxAdmin}) {
    return GroupMemberState(
      status: status ?? this.status,
      members: members ?? this.members,
      indexMember: indexMember ?? this.indexMember,
      hasReachedMaxMember:
      hasReachedMaxMember ?? this.hasReachedMaxMember,
      indexAdmin: indexAdmin ?? this.indexAdmin,
      admins: admins ?? this.admins,
      hasReachedMaxAdmin:
      hasReachedMaxAdmin ?? this.hasReachedMaxAdmin,
    );
  }
}