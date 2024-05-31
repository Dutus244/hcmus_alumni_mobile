import 'package:flutter_bloc/flutter_bloc.dart';

import 'news_detail_events.dart';
import 'news_detail_states.dart';

class NewsDetailBloc extends Bloc<NewsDetailEvent, NewsDetailState> {
  NewsDetailBloc() : super(NewsDetailState()) {
    on<FontSizeEvent>(_fontSizeEvent);
    on<FontSizeResetEvent>(_fontSizeResetEvent);
    on<FontFamilyEvent>(_fontFamilyEvent);
    on<NewsEvent>(_newsEvent);
    on<CommentsEvent>(_commentsEvent);
    on<IndexCommentEvent>(_indexCommentEvent);
    on<HasReachedMaxCommentEvent>(_hasReachedMaxCommentEvent);
    on<RelatedNewsEvent>(_relatedNewsEvent);
  }

  void _fontSizeEvent(FontSizeEvent event, Emitter<NewsDetailState> emit) {
    emit(state.copyWith(fontSize: event.fontSize));
  }

  void _fontSizeResetEvent(
      FontSizeResetEvent event, Emitter<NewsDetailState> emit) {
    emit(state.copyWith(fontSize: 40));
  }

  void _fontFamilyEvent(FontFamilyEvent event, Emitter<NewsDetailState> emit) {
    emit(state.copyWith(fontFamily: event.fontFamily));
  }

  void _newsEvent(NewsEvent event, Emitter<NewsDetailState> emit) {
    emit(state.copyWith(news: event.news));
  }

  void _commentsEvent(CommentsEvent event, Emitter<NewsDetailState> emit) async {
    emit(state.copyWith(comments: event.comments));
  }

  void _indexCommentEvent(
      IndexCommentEvent event, Emitter<NewsDetailState> emit) {
    emit(state.copyWith(indexComment: event.indexComment));
  }

  void _hasReachedMaxCommentEvent(
      HasReachedMaxCommentEvent event, Emitter<NewsDetailState> emit) {
    emit(state.copyWith(hasReachedMaxComment: event.hasReachedMaxComment));
  }

  void _relatedNewsEvent(
      RelatedNewsEvent event, Emitter<NewsDetailState> emit) {
    emit(state.copyWith(relatedNews: event.relatedNews));
  }
}
