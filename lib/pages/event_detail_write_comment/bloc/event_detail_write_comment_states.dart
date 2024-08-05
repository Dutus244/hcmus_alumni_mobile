class EventDetailWriteCommentState {
  final String comment;
  final bool isLoading;

  EventDetailWriteCommentState({this.comment = "", this.isLoading = false});

  EventDetailWriteCommentState copyWith({String? comment, bool? isLoading}) {
    return EventDetailWriteCommentState(
      comment: comment ?? this.comment,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
