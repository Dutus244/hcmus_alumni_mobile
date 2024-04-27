import 'package:flutter_bloc/flutter_bloc.dart';

import 'news_detail_write_children_comment_events.dart';
import 'news_detail_write_children_comment_states.dart';

class NewsDetailWriteChildrenCommentBloc extends Bloc<
    NewsDetailWriteChildrenCommentEvent, NewsDetailWriteChildrenCommentState> {
  NewsDetailWriteChildrenCommentBloc()
      : super(NewsDetailWriteChildrenCommentState()) {
    on<CommentEvent>(_commentEvent);
    ;
    on<NewsDetailWriteChildrenCommentResetEvent>(
        _newsDetailWriteChildrenCommentResetEvent);
  }

  void _commentEvent(
      CommentEvent event, Emitter<NewsDetailWriteChildrenCommentState> emit) {
    emit(state.copyWith(comment: event.comment));
  }

  void _newsDetailWriteChildrenCommentResetEvent(
      NewsDetailWriteChildrenCommentResetEvent event,
      Emitter<NewsDetailWriteChildrenCommentState> emit) {
    emit(
        NewsDetailWriteChildrenCommentState()); // Reset the state to its initial state
  }
}
