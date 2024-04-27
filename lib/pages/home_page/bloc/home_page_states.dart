import '../../../model/hall_of_fame.dart';
import '../../../model/news.dart';
import '../../../model/event.dart';

class HomePageState {
  final List<Event> event;
  final List<News> news;
  final List<HallOfFame> hallOfFame;

  HomePageState(
      {this.event = const [],
      this.news = const [],
      this.hallOfFame = const []});

  HomePageState copyWith(
      {List<Event>? event, List<News>? news, List<HallOfFame>? hallOfFame}) {
    return HomePageState(
        event: event ?? this.event,
        news: news ?? this.news,
        hallOfFame: hallOfFame ?? this.hallOfFame);
  }
}
