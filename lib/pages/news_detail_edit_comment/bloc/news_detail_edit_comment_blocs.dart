import 'package:flutter_bloc/flutter_bloc.dart';

import 'news_detail_edit_comment_events.dart';
import 'news_detail_edit_comment_states.dart';

class NewsDetailEditCommentBloc
    extends Bloc<NewsDetailEditCommentEvent, NewsDetailEditCommentState> {
  NewsDetailEditCommentBloc() : super(NewsDetailEditCommentState()) {
    on<CommentEvent>(_commentEvent);
    on<IsLoadingEvent>(_isLoadingEvent);
    on<NewsDetailEditCommentResetEvent>(_newsDetailEditCommentResetEvent);
  }

  void _commentEvent(
      CommentEvent event, Emitter<NewsDetailEditCommentState> emit) {
    emit(state.copyWith(comment: event.comment));
  }

  void _isLoadingEvent(
      IsLoadingEvent event, Emitter<NewsDetailEditCommentState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _newsDetailEditCommentResetEvent(NewsDetailEditCommentResetEvent event,
      Emitter<NewsDetailEditCommentState> emit) {
    emit(NewsDetailEditCommentState()); // Reset the state to its initial state
  }
}
