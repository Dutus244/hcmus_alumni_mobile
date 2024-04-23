import '../../../model/news.dart';
import '../../../model/event.dart';

class HomePageState {
  final List<Event> event;
  final List<News> news;

  HomePageState({this.event = const [], this.news = const []});

  HomePageState copyWith({List<Event>? event, List<News>? news}) {
    return HomePageState(event: event ?? this.event, news: news ?? this.news);
  }
}
