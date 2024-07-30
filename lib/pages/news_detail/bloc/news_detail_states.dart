import 'package:hcmus_alumni_mobile/model/comment.dart';
import 'package:hcmus_alumni_mobile/model/faculty.dart';
import 'package:hcmus_alumni_mobile/model/status.dart';

import '../../../model/news.dart';

class NewsDetailState {
  final double fontSize;
  final String fontFamily;
  final News? news;
  final List<Comment> comments;
  final int indexComment;
  final bool hasReachedMaxComment;
  final List<News> relatedNews;

  NewsDetailState(
      {this.fontSize = 40,
      this.fontFamily = "Roboto",
      this.news = null,
      this.comments = const [],
      this.indexComment = 0,
      this.hasReachedMaxComment = false,
      this.relatedNews = const []});

  NewsDetailState copyWith(
      {double? fontSize,
      String? fontFamily,
      News? news,
      List<Comment>? comments,
      int? indexComment,
      bool? hasReachedMaxComment,
      List<News>? relatedNews}) {
    return NewsDetailState(
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      news: news ?? this.news,
      comments: comments ?? this.comments,
      indexComment: indexComment ?? this.indexComment,
      hasReachedMaxComment: hasReachedMaxComment ?? this.hasReachedMaxComment,
      relatedNews: relatedNews ?? this.relatedNews,
    );
  }
}
