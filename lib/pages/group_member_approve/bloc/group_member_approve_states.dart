import 'package:hcmus_alumni_mobile/model/request_group.dart';

enum Status { loading, success }

class GroupMemberApproveState {
  final Status status;
  final List<RequestGroup> requests;
  final int indexRequest;
  final bool hasReachedMaxRequest;

  GroupMemberApproveState({
    this.status = Status.loading,
    this.requests = const [],
    this.indexRequest = 0,
    this.hasReachedMaxRequest = false,
  });

  GroupMemberApproveState copyWith(
      {Status? status,
      List<RequestGroup>? requests,
      int? indexRequest,
      bool? hasReachedMaxRequest}) {
    return GroupMemberApproveState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
      indexRequest: indexRequest ?? this.indexRequest,
      hasReachedMaxRequest: hasReachedMaxRequest ?? this.hasReachedMaxRequest,
    );
  }
}
