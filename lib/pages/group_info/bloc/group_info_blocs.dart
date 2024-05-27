import 'package:flutter_bloc/flutter_bloc.dart';

import 'group_info_events.dart';
import 'group_info_states.dart';

class GroupInfoBloc extends Bloc<GroupInfoEvent, GroupInfoState> {
  GroupInfoBloc() : super(GroupInfoState()) {
    on<MemberEvent>(_memberEvent);
    on<AdminEvent>(_adminEvent);
  }

  void _memberEvent(MemberEvent event, Emitter<GroupInfoState> emit) async {
    emit(state.copyWith(member: event.member));
  }

  void _adminEvent(AdminEvent event, Emitter<GroupInfoState> emit) async {
    emit(state.copyWith(admin: event.admin));
  }
}
