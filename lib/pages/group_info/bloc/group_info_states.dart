import 'package:hcmus_alumni_mobile/model/member.dart';

class GroupInfoState {
  final List<Member> members;
  final List<Member> admins;

  GroupInfoState({this.members = const [], this.admins = const []});

  GroupInfoState copyWith({
    List<Member>? members,
    List<Member>? admins,
  }) {
    return GroupInfoState(
      members: members ?? this.members,
      admins: admins ?? this.admins,
    );
  }
}
