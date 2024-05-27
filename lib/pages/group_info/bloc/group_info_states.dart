import 'package:hcmus_alumni_mobile/model/member.dart';

class GroupInfoState {
  final List<Member> member;
  final List<Member> admin;

  GroupInfoState({this.member = const [], this.admin = const []});

  GroupInfoState copyWith({
    List<Member>? member,
    List<Member>? admin,
  }) {
    return GroupInfoState(
      member: member ?? this.member,
      admin: admin ?? this.admin,
    );
  }
}
