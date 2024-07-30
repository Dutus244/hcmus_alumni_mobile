class NewsDetailEditCommentState {
  final String comment;

  NewsDetailEditCommentState({this.comment = ""});

  NewsDetailEditCommentState copyWith({String? comment}) {
    return NewsDetailEditCommentState(
      comment: comment ?? this.comment,
    );
  }
}
