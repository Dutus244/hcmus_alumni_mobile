class EventDetailWriteChildrenCommentState {
  final String comment;

  EventDetailWriteChildrenCommentState({this.comment = ""});

  EventDetailWriteChildrenCommentState copyWith({String? comment}) {
    return EventDetailWriteChildrenCommentState(
      comment: comment ?? this.comment,
    );
  }
}
