class EventDetailWriteChildrenCommentState {
  final String comment;
  final bool isLoading;

  EventDetailWriteChildrenCommentState({this.comment = "", this.isLoading = false});

  EventDetailWriteChildrenCommentState copyWith({String? comment, bool? isLoading}) {
    return EventDetailWriteChildrenCommentState(
      comment: comment ?? this.comment,
      isLoading: isLoading ?? this.isLoading
    );
  }
}
