import 'package:flutter_bloc/flutter_bloc.dart';

import 'group_member_approve_events.dart';
import 'group_member_approve_states.dart';

class GroupMemberApproveBloc
    extends Bloc<GroupMemberApproveEvent, GroupMemberApproveState> {
  GroupMemberApproveBloc() : super(GroupMemberApproveState()) {
    on<StatusEvent>(_statusEvent);
    on<RequestsEvent>(_requestsEvent);
    on<IndexRequestEvent>(_indexRequestEvent);
    on<IsLoadingEvent>(_isLoadingEvent);
    on<HasReachedMaxRequestEvent>(_hasReachedMaxRequestEvent);
  }

  void _statusEvent(
      StatusEvent event, Emitter<GroupMemberApproveState> emit) async {
    emit(state.copyWith(status: event.status));
  }

  void _requestsEvent(
      RequestsEvent event, Emitter<GroupMemberApproveState> emit) async {
    emit(state.copyWith(requests: event.requests));
  }

  void _indexRequestEvent(
      IndexRequestEvent event, Emitter<GroupMemberApproveState> emit) {
    emit(state.copyWith(indexRequest: event.indexRequest));
  }

  void _isLoadingEvent(
      IsLoadingEvent event, Emitter<GroupMemberApproveState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _hasReachedMaxRequestEvent(
      HasReachedMaxRequestEvent event, Emitter<GroupMemberApproveState> emit) {
    emit(state.copyWith(hasReachedMaxRequest: event.hasReachedMaxRequest));
  }
}
