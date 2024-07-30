import '../../../model/hall_of_fame.dart';
import '../../../model/news.dart';
import '../../../model/event.dart';

class HomePageState {
  final List<Event> events;
  final List<News> news;
  final List<HallOfFame> hallOfFames;

  HomePageState(
      {this.events = const [],
      this.news = const [],
      this.hallOfFames = const []});

  HomePageState copyWith(
      {List<Event>? events, List<News>? news, List<HallOfFame>? hallOfFames}) {
    return HomePageState(
        events: events ?? this.events,
        news: news ?? this.news,
        hallOfFames: hallOfFames ?? this.hallOfFames);
  }
}
