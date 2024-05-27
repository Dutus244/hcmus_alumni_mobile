import 'package:flutter_bloc/flutter_bloc.dart';

import 'group_management_events.dart';
import 'group_management_states.dart';

class GroupManagementBloc extends Bloc<GroupManagementEvent, GroupManagementState> {
  GroupManagementBloc() : super(GroupManagementState()) {
    on<GroupEvent>(_groupEvent);
  }

  void _groupEvent(GroupEvent event, Emitter<GroupManagementState> emit) {
    emit(state.copyWith(group: event.group));
  }
}