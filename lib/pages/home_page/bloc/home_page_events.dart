import '../../../model/hall_of_fame.dart';
import '../../../model/news.dart';
import '../../../model/event.dart';

class HomePageEvent {
  const HomePageEvent();
}

class EventsEvent extends HomePageEvent {
  final List<Event> events;

  const EventsEvent(this.events);
}

class NewsEvent extends HomePageEvent {
  final List<News> news;

  const NewsEvent(this.news);
}

class HallOfFamesEvent extends HomePageEvent {
  final List<HallOfFame> hallOfFames;

  const HallOfFamesEvent(this.hallOfFames);
}
