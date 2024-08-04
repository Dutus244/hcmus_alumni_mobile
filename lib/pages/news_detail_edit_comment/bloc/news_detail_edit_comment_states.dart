class NewsDetailEditCommentState {
  final String comment;
  final bool isLoading;

  NewsDetailEditCommentState({this.comment = "", this.isLoading = false});

  NewsDetailEditCommentState copyWith({String? comment, bool? isLoading}) {
    return NewsDetailEditCommentState(
      comment: comment ?? this.comment,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
