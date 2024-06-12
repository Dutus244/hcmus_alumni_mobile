import '../../../model/voter.dart';
import 'group_detail_list_voters_states.dart';

class GroupDetailListVotersEvent {
  const GroupDetailListVotersEvent();
}

class StatusVoterEvent extends GroupDetailListVotersEvent {
  final Status statusVoter;

  const StatusVoterEvent(this.statusVoter);
}

class VotersEvent extends GroupDetailListVotersEvent {
  final List<Voter> voters;

  const VotersEvent(this.voters);
}

class IndexVoterEvent extends GroupDetailListVotersEvent {
  final int indexVoter;

  const IndexVoterEvent(this.indexVoter);
}

class HasReachedMaxVoterEvent extends GroupDetailListVotersEvent {
  final bool hasReachedMaxVoter;

  const HasReachedMaxVoterEvent(this.hasReachedMaxVoter);
}

class GroupDetailListVotersResetEvent extends GroupDetailListVotersEvent {}