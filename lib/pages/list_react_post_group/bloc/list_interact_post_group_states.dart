import '../../../model/interact.dart';

enum Status { loading, success }

class ListInteractPostGroupState {
  final Status statusInteract;
  final List<Interact> interact;
  final int indexInteract;
  final bool hasReachedMaxInteract;

  ListInteractPostGroupState(
      {this.statusInteract = Status.loading,
      this.interact = const [],
      this.indexInteract = 0,
      this.hasReachedMaxInteract = false});

  ListInteractPostGroupState copyWith(
      {Status? statusInteract,
      List<Interact>? interact,
      int? indexInteract,
      bool? hasReachedMaxInteract}) {
    return ListInteractPostGroupState(
      statusInteract: statusInteract ?? this.statusInteract,
      interact: interact ?? this.interact,
      indexInteract: indexInteract ?? this.indexInteract,
      hasReachedMaxInteract:
          hasReachedMaxInteract ?? this.hasReachedMaxInteract,
    );
  }
}
