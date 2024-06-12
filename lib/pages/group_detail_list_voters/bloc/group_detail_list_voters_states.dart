import 'package:hcmus_alumni_mobile/model/post.dart';

import '../../../model/voter.dart';

enum Status { loading, success }

class GroupDetailListVotersState {
  final Status statusVoter;
  final List<Voter> voters;
  final int indexVoter;
  final bool hasReachedMaxVoter;


  GroupDetailListVotersState({
    this.statusVoter = Status.loading,
    this.voters = const [],
    this.indexVoter = 0,
    this.hasReachedMaxVoter = false
  });

  GroupDetailListVotersState copyWith({
    Status? statusVoter,
    List<Voter>? voters,
    int? indexVoter,
    bool? hasReachedMaxVoter,
  }) {
    return GroupDetailListVotersState(
        statusVoter: statusVoter ?? this.statusVoter,
        voters: voters ?? this.voters,
        indexVoter: indexVoter ?? this.indexVoter,
        hasReachedMaxVoter: hasReachedMaxVoter ?? this.hasReachedMaxVoter);
  }
}
