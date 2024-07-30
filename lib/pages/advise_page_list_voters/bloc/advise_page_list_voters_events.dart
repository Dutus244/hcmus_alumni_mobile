import '../../../model/voter.dart';
import 'advise_page_list_voters_states.dart';

class AdvisePageListVotersEvent {
  const AdvisePageListVotersEvent();
}

class StatusVoterEvent extends AdvisePageListVotersEvent {
  final Status statusVoter;

  const StatusVoterEvent(this.statusVoter);
}

class VotersEvent extends AdvisePageListVotersEvent {
  final List<Voter> voters;

  const VotersEvent(this.voters);
}

class IndexVoterEvent extends AdvisePageListVotersEvent {
  final int indexVoter;

  const IndexVoterEvent(this.indexVoter);
}

class HasReachedMaxVoterEvent extends AdvisePageListVotersEvent {
  final bool hasReachedMaxVoter;

  const HasReachedMaxVoterEvent(this.hasReachedMaxVoter);
}

class AdvisePageListVotersResetEvent extends AdvisePageListVotersEvent {}