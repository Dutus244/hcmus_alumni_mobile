class NewsDetailWriteCommentState {
  final String comment;
  final bool isLoading;

  NewsDetailWriteCommentState({this.comment = "", this.isLoading = false});

  NewsDetailWriteCommentState copyWith({String? comment, bool? isLoading}) {
    return NewsDetailWriteCommentState(
      comment: comment ?? this.comment,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
