import 'package:hcmus_alumni_mobile/model/event.dart';

import '../../../model/news.dart';

enum Status { loading, success }

class NewsEventPageState {
  final int page;

  final Status statusNews;
  final List<News> news;
  final int indexNews;
  final bool hasReachedMaxNews;

  final Status statusEvent;
  final List<Event> events;
  final int indexEvent;
  final bool hasReachedMaxEvent;

  NewsEventPageState({
    this.page = 0,
    this.statusNews = Status.loading,
    this.news = const [],
    this.indexNews = 0,
    this.hasReachedMaxNews = false,
    this.statusEvent = Status.loading,
    this.events = const [],
    this.indexEvent = 0,
    this.hasReachedMaxEvent = false,
  });

  NewsEventPageState copyWith({
    int? page,
    Status? statusNews,
    List<News>? news,
    int? indexNews,
    bool? hasReachedMaxNews,
    Status? statusEvent,
    List<Event>? events,
    int? indexEvent,
    bool? hasReachedMaxEvent,
  }) {
    return NewsEventPageState(
        page: page ?? this.page,
        statusNews: statusNews ?? this.statusNews,
        news: news ?? this.news,
        indexNews: indexNews ?? this.indexNews,
        hasReachedMaxNews: hasReachedMaxNews ?? this.hasReachedMaxNews,
        statusEvent: statusEvent ?? this.statusEvent,
        events: events ?? this.events,
        indexEvent: indexEvent ?? this.indexEvent,
        hasReachedMaxEvent: hasReachedMaxEvent ?? this.hasReachedMaxEvent);
  }
}
