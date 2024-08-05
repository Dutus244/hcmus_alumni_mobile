import 'package:hcmus_alumni_mobile/model/group_request.dart';

enum Status { loading, success }

class GroupMemberApproveState {
  final Status status;
  final List<GroupRequest> requests;
  final int indexRequest;
  final bool hasReachedMaxRequest;
  final bool isLoading;

  GroupMemberApproveState({
    this.status = Status.loading,
    this.requests = const [],
    this.indexRequest = 0,
    this.hasReachedMaxRequest = false,
    this.isLoading = false,
  });

  GroupMemberApproveState copyWith(
      {Status? status,
      List<GroupRequest>? requests,
      int? indexRequest,
      bool? hasReachedMaxRequest,
      bool? isLoading}) {
    return GroupMemberApproveState(
      status: status ?? this.status,
      requests: requests ?? this.requests,
      indexRequest: indexRequest ?? this.indexRequest,
      hasReachedMaxRequest: hasReachedMaxRequest ?? this.hasReachedMaxRequest,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
