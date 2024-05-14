import '../../../model/interact.dart';
import 'list_interact_post_advise_states.dart';

class ListInteractPostAdviseEvent {
  const ListInteractPostAdviseEvent();
}

class StatusInteractEvent extends ListInteractPostAdviseEvent {
  final Status statusInteract;

  const StatusInteractEvent(this.statusInteract);
}

class InteractEvent extends ListInteractPostAdviseEvent {
  final List<Interact> interact;

  const InteractEvent(this.interact);
}

class IndexInteractEvent extends ListInteractPostAdviseEvent {
  final int indexInteract;

  const IndexInteractEvent(this.indexInteract);
}

class HasReachedMaxInteractEvent extends ListInteractPostAdviseEvent {
  final bool hasReachedMaxInteract;

  const HasReachedMaxInteractEvent(this.hasReachedMaxInteract);
}
