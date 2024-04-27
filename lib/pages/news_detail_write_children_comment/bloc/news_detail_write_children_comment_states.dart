class NewsDetailWriteChildrenCommentState {
  final String comment;

  NewsDetailWriteChildrenCommentState({this.comment = ""});

  NewsDetailWriteChildrenCommentState copyWith({String? comment}) {
    return NewsDetailWriteChildrenCommentState(
      comment: comment ?? this.comment,
    );
  }
}
