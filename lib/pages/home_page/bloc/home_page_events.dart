import '../../../model/hall_of_fame.dart';
import '../../../model/news.dart';
import '../../../model/event.dart';

class HomePageEvent {
  const HomePageEvent();
}

class EventEvent extends HomePageEvent {
  final List<Event> event;

  const EventEvent(this.event);
}

class NewsEvent extends HomePageEvent {
  final List<News> news;

  const NewsEvent(this.news);
}

class HallOfFameEvent extends HomePageEvent {
  final List<HallOfFame> hallOfFame;

  const HallOfFameEvent(this.hallOfFame);
}
