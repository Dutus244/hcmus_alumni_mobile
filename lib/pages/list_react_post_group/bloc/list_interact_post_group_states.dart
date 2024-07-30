import '../../../model/interact.dart';

enum Status { loading, success }

class ListInteractPostGroupState {
  final Status statusInteract;
  final List<Interact> interacts;
  final int indexInteract;
  final bool hasReachedMaxInteract;

  ListInteractPostGroupState(
      {this.statusInteract = Status.loading,
      this.interacts = const [],
      this.indexInteract = 0,
      this.hasReachedMaxInteract = false});

  ListInteractPostGroupState copyWith(
      {Status? statusInteract,
      List<Interact>? interacts,
      int? indexInteract,
      bool? hasReachedMaxInteract}) {
    return ListInteractPostGroupState(
      statusInteract: statusInteract ?? this.statusInteract,
      interacts: interacts ?? this.interacts,
      indexInteract: indexInteract ?? this.indexInteract,
      hasReachedMaxInteract:
          hasReachedMaxInteract ?? this.hasReachedMaxInteract,
    );
  }
}
