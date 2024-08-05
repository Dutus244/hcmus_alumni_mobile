class NewsDetailWriteChildrenCommentState {
  final String comment;
  final bool isLoading;

  NewsDetailWriteChildrenCommentState({this.comment = "", this.isLoading = false});

  NewsDetailWriteChildrenCommentState copyWith({String? comment, bool? isLoading}) {
    return NewsDetailWriteChildrenCommentState(
      comment: comment ?? this.comment,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
