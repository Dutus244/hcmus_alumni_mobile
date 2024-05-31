import 'package:hcmus_alumni_mobile/model/request_group.dart';

import 'group_member_approve_states.dart';

class GroupMemberApproveEvent {
  const GroupMemberApproveEvent();
}

class StatusEvent extends GroupMemberApproveEvent {
  final Status status;

  const StatusEvent(this.status);
}

class RequestsEvent extends GroupMemberApproveEvent {
  final List<RequestGroup> requests;

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