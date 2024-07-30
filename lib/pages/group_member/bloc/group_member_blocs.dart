import 'package:flutter_bloc/flutter_bloc.dart';

import 'group_member_events.dart';
import 'group_member_states.dart';

class GroupMemberBloc extends Bloc<GroupMemberEvent, GroupMemberState> {
  GroupMemberBloc() : super(GroupMemberState()) {
    on<StatusEvent>(_statusEvent);
    on<MembersEvent>(_membersEvent);
    on<IndexMemberEvent>(_indexMemberEvent);
    on<HasReachedMaxMemberEvent>(_hasReachedMaxMemberEvent);
    on<AdminsEvent>(_adminsEvent);
    on<IndexAdminEvent>(_indexAdminEvent);
    on<HasReachedMaxAdminEvent>(_hasReachedMaxAdminEvent);
  }

  void _statusEvent(StatusEvent event, Emitter<GroupMemberState> emit) async {
    emit(state.copyWith(status: event.status));
  }

  void _membersEvent(MembersEvent event, Emitter<GroupMemberState> emit) async {
    emit(state.copyWith(members: event.members));
  }

  void _indexMemberEvent(
      IndexMemberEvent event, Emitter<GroupMemberState> emit) {
    emit(state.copyWith(indexMember: event.indexMember));
  }

  void _hasReachedMaxMemberEvent(
      HasReachedMaxMemberEvent event, Emitter<GroupMemberState> emit) {
    emit(state.copyWith(hasReachedMaxMember: event.hasReachedMaxMember));
  }

  void _adminsEvent(AdminsEvent event, Emitter<GroupMemberState> emit) async {
    emit(state.copyWith(admins: event.admins));
  }

  void _indexAdminEvent(IndexAdminEvent event, Emitter<GroupMemberState> emit) {
    emit(state.copyWith(indexAdmin: event.indexAdmin));
  }

  void _hasReachedMaxAdminEvent(
      HasReachedMaxAdminEvent event, Emitter<GroupMemberState> emit) {
    emit(state.copyWith(hasReachedMaxAdmin: event.hasReachedMaxAdmin));
  }
}
