class EventDetailEditCommentState {
  final String comment;

  EventDetailEditCommentState({this.comment = ""});

  EventDetailEditCommentState copyWith({String? comment}) {
    return EventDetailEditCommentState(
      comment: comment ?? this.comment,
    );
  }
}
