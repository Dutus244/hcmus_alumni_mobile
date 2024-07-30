import '../../../model/interact.dart';

enum Status { loading, success }

class ListInteractPostAdviseState {
  final Status statusInteract;
  final List<Interact> interacts;
  final int indexInteract;
  final bool hasReachedMaxInteract;

  ListInteractPostAdviseState(
      {this.statusInteract = Status.loading,
      this.interacts = const [],
      this.indexInteract = 0,
      this.hasReachedMaxInteract = false});

  ListInteractPostAdviseState copyWith(
      {Status? statusInteract,
      List<Interact>? interacts,
      int? indexInteract,
      bool? hasReachedMaxInteract}) {
    return ListInteractPostAdviseState(
      statusInteract: statusInteract ?? this.statusInteract,
      interacts: interacts ?? this.interacts,
      indexInteract: indexInteract ?? this.indexInteract,
      hasReachedMaxInteract:
          hasReachedMaxInteract ?? this.hasReachedMaxInteract,
    );
  }
}
