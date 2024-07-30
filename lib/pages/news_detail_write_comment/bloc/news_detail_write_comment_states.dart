class NewsDetailWriteCommentState {
  final String comment;

  NewsDetailWriteCommentState({this.comment = ""});

  NewsDetailWriteCommentState copyWith({String? comment}) {
    return NewsDetailWriteCommentState(
      comment: comment ?? this.comment,
    );
  }
}
