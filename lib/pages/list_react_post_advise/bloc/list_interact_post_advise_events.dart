import '../../../model/interact.dart';
import 'list_interact_post_advise_states.dart';

class ListInteractPostAdviseEvent {
  const ListInteractPostAdviseEvent();
}

class StatusInteractEvent extends ListInteractPostAdviseEvent {
  final Status statusInteract;

  const StatusInteractEvent(this.statusInteract);
}

class InteractsEvent extends ListInteractPostAdviseEvent {
  final List<Interact> interacts;

  const InteractsEvent(this.interacts);
}

class IndexInteractEvent extends ListInteractPostAdviseEvent {
  final int indexInteract;

  const IndexInteractEvent(this.indexInteract);
}

class HasReachedMaxInteractEvent extends ListInteractPostAdviseEvent {
  final bool hasReachedMaxInteract;

  const HasReachedMaxInteractEvent(this.hasReachedMaxInteract);
}
