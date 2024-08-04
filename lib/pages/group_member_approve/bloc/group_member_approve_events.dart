import 'package:hcmus_alumni_mobile/model/group_request.dart';

import 'group_member_approve_states.dart';

class GroupMemberApproveEvent {
  const GroupMemberApproveEvent();
}

class StatusEvent extends GroupMemberApproveEvent {
  final Status status;

  const StatusEvent(this.status);
}

class RequestsEvent extends GroupMemberApproveEvent {
  final List<GroupRequest> requests;

  const RequestsEvent(this.requests);
}

class IndexRequestEvent extends GroupMemberApproveEvent {
  final int indexRequest;

  const IndexRequestEvent(this.indexRequest);
}

class HasReachedMaxRequestEvent extends GroupMemberApproveEvent {
  final bool hasReachedMaxRequest;

  const HasReachedMaxRequestEvent(this.hasReachedMaxRequest);
}

class IsLoadingEvent extends GroupMemberApproveEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}