import 'news.dart';

class NewsResponse {
  final List<News> news;

  NewsResponse(this.news);

  NewsResponse.fromJson(Map<String, dynamic> json)
      : news = (json["news"] as List).map((i) => new News.fromJson(i)).toList();
}
