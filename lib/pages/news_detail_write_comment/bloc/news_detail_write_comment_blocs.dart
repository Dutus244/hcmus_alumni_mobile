import 'package:flutter_bloc/flutter_bloc.dart';

import 'news_detail_write_comment_events.dart';
import 'news_detail_write_comment_states.dart';

class NewsDetailWriteCommentBloc
    extends Bloc<NewsDetailWriteCommentEvent, NewsDetailWriteCommentState> {
  NewsDetailWriteCommentBloc() : super(NewsDetailWriteCommentState()) {
    on<CommentEvent>(_commentEvent);
    on<IsLoadingEvent>(_isLoadingEvent);
    on<NewsDetailWriteCommentResetEvent>(_newsDetailWriteCommentResetEvent);
  }

  void _commentEvent(
      CommentEvent event, Emitter<NewsDetailWriteCommentState> emit) {
    emit(state.copyWith(comment: event.comment));
  }

  void _isLoadingEvent(
      IsLoadingEvent event, Emitter<NewsDetailWriteCommentState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _newsDetailWriteCommentResetEvent(NewsDetailWriteCommentResetEvent event,
      Emitter<NewsDetailWriteCommentState> emit) {
    emit(NewsDetailWriteCommentState()); // Reset the state to its initial state
  }
}
