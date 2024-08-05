class EventDetailEditCommentState {
  final String comment;
  final bool isLoading;

  EventDetailEditCommentState({this.comment = "", this.isLoading = false});

  EventDetailEditCommentState copyWith({String? comment, bool? isLoading}) {
    return EventDetailEditCommentState(
      comment: comment ?? this.comment,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
