class EventDetailWriteCommentState {
  final String comment;

  EventDetailWriteCommentState({this.comment = ""});

  EventDetailWriteCommentState copyWith({String? comment}) {
    return EventDetailWriteCommentState(
      comment: comment ?? this.comment,
    );
  }
}
