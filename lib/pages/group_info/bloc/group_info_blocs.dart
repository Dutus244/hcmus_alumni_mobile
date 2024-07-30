import 'package:flutter_bloc/flutter_bloc.dart';

import 'group_info_events.dart';
import 'group_info_states.dart';

class GroupInfoBloc extends Bloc<GroupInfoEvent, GroupInfoState> {
  GroupInfoBloc() : super(GroupInfoState()) {
    on<MembersEvent>(_membersEvent);
    on<AdminsEvent>(_adminsEvent);
  }

  void _membersEvent(MembersEvent event, Emitter<GroupInfoState> emit) async {
    emit(state.copyWith(members: event.members));
  }

  void _adminsEvent(AdminsEvent event, Emitter<GroupInfoState> emit) async {
    emit(state.copyWith(admins: event.admins));
  }
}
