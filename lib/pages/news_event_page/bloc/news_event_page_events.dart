import 'package:hcmus_alumni_mobile/model/event.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/bloc/news_event_page_states.dart';

import '../../../model/news.dart';

class NewsEventPageEvent {
  const NewsEventPageEvent();
}

class PageEvent extends NewsEventPageEvent {
  final int page;

  const PageEvent(this.page);
}

class StatusNewsEvent extends NewsEventPageEvent {
  final Status statusNews;

  const StatusNewsEvent(this.statusNews);
}

class NewsEvent extends NewsEventPageEvent {
  final List<News> news;

  const NewsEvent(this.news);
}

class IndexNewsEvent extends NewsEventPageEvent {
  final int indexNews;

  const IndexNewsEvent(this.indexNews);
}

class HasReachedMaxNewsEvent extends NewsEventPageEvent {
  final bool hasReachedMaxNews;

  const HasReachedMaxNewsEvent(this.hasReachedMaxNews);
}

class StatusEventEvent extends NewsEventPageEvent {
  final Status statusEvent;

  const StatusEventEvent(this.statusEvent);
}

class EventEvent extends NewsEventPageEvent {
  final List<Event> event;

  const EventEvent(this.event);
}

class IndexEventEvent extends NewsEventPageEvent {
  final int indexEvent;

  const IndexEventEvent(this.indexEvent);
}

class HasReachedMaxEventEvent extends NewsEventPageEvent {
  final bool hasReachedMaxEvent;

  const HasReachedMaxEventEvent(this.hasReachedMaxEvent);
}
