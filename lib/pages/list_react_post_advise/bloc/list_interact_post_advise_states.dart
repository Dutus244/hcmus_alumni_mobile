import '../../../model/interact.dart';

enum Status { loading, success }

class ListInteractPostAdviseState {
  final Status statusInteract;
  final List<Interact> interact;
  final int indexInteract;
  final bool hasReachedMaxInteract;

  ListInteractPostAdviseState(
      {this.statusInteract = Status.loading,
      this.interact = const [],
      this.indexInteract = 0,
      this.hasReachedMaxInteract = false});

  ListInteractPostAdviseState copyWith(
      {Status? statusInteract,
      List<Interact>? interact,
      int? indexInteract,
      bool? hasReachedMaxInteract}) {
    return ListInteractPostAdviseState(
      statusInteract: statusInteract ?? this.statusInteract,
      interact: interact ?? this.interact,
      indexInteract: indexInteract ?? this.indexInteract,
      hasReachedMaxInteract:
          hasReachedMaxInteract ?? this.hasReachedMaxInteract,
    );
  }
}
