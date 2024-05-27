import 'package:hcmus_alumni_mobile/model/request_group.dart';

enum Status { loading, success }

class GroupMemberApproveState {
  final Status status;
  final List<RequestGroup> request;
  final int indexRequest;
  final bool hasReachedMaxRequest;

  GroupMemberApproveState({
    this.status = Status.loading,
    this.request = const [],
    this.indexRequest = 0,
    this.hasReachedMaxRequest = false,
  });

  GroupMemberApproveState copyWith(
      {Status? status,
      List<RequestGroup>? request,
      int? indexRequest,
      bool? hasReachedMaxRequest}) {
    return GroupMemberApproveState(
      status: status ?? this.status,
      request: request ?? this.request,
      indexRequest: indexRequest ?? this.indexRequest,
      hasReachedMaxRequest: hasReachedMaxRequest ?? this.hasReachedMaxRequest,
    );
  }
}
