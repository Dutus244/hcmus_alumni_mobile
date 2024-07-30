import 'package:flutter_bloc/flutter_bloc.dart';

import 'news_event_page_events.dart';
import 'news_event_page_states.dart';

class NewsEventPageBloc extends Bloc<NewsEventPageEvent, NewsEventPageState> {
  NewsEventPageBloc() : super(NewsEventPageState()) {
    on<PageEvent>(_pageEvent);
    on<StatusNewsEvent>(_statusNewsEvent);
    on<NewsEvent>(_newsEvent);
    on<IndexNewsEvent>(_indexNewsEvent);
    on<HasReachedMaxNewsEvent>(_hasReachedMaxNewsEvent);
    on<StatusEventEvent>(_statusEventEvent);
    on<EventsEvent>(_eventsEvent);
    on<IndexEventEvent>(_indexEventEvent);
    on<HasReachedMaxEventEvent>(_hasReachedMaxEventEvent);
  }

  void _pageEvent(PageEvent event, Emitter<NewsEventPageState> emit) {
    emit(state.copyWith(page: event.page));
  }

  void _statusNewsEvent(
      StatusNewsEvent event, Emitter<NewsEventPageState> emit) async {
    emit(state.copyWith(statusNews: event.statusNews));
  }

  void _newsEvent(NewsEvent event, Emitter<NewsEventPageState> emit) async {
    emit(state.copyWith(news: event.news));
  }

  void _indexNewsEvent(IndexNewsEvent event, Emitter<NewsEventPageState> emit) {
    emit(state.copyWith(indexNews: event.indexNews));
  }

  void _hasReachedMaxNewsEvent(
      HasReachedMaxNewsEvent event, Emitter<NewsEventPageState> emit) {
    emit(state.copyWith(hasReachedMaxNews: event.hasReachedMaxNews));
  }

  void _statusEventEvent(
      StatusEventEvent event, Emitter<NewsEventPageState> emit) async {
    emit(state.copyWith(statusEvent: event.statusEvent));
  }

  void _eventsEvent(EventsEvent event, Emitter<NewsEventPageState> emit) async {
    emit(state.copyWith(events: event.events));
  }

  void _indexEventEvent(
      IndexEventEvent event, Emitter<NewsEventPageState> emit) {
    emit(state.copyWith(indexEvent: event.indexEvent));
  }

  void _hasReachedMaxEventEvent(
      HasReachedMaxEventEvent event, Emitter<NewsEventPageState> emit) {
    emit(state.copyWith(hasReachedMaxEvent: event.hasReachedMaxEvent));
  }
}
