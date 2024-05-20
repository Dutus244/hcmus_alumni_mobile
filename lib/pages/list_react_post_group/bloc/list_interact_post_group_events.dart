import '../../../model/interact.dart';
import 'list_interact_post_group_states.dart';

class ListInteractPostGroupEvent {
  const ListInteractPostGroupEvent();
}

class StatusInteractEvent extends ListInteractPostGroupEvent {
  final Status statusInteract;

  const StatusInteractEvent(this.statusInteract);
}

class InteractEvent extends ListInteractPostGroupEvent {
  final List<Interact> interact;

  const InteractEvent(this.interact);
}

class IndexInteractEvent extends ListInteractPostGroupEvent {
  final int indexInteract;

  const IndexInteractEvent(this.indexInteract);
}

class HasReachedMaxInteractEvent extends ListInteractPostGroupEvent {
  final bool hasReachedMaxInteract;

  const HasReachedMaxInteractEvent(this.hasReachedMaxInteract);
}
