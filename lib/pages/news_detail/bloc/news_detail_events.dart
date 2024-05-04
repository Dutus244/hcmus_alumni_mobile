import 'package:hcmus_alumni_mobile/model/comment.dart';

import '../../../model/news.dart';

class NewsDetailEvent {
  const NewsDetailEvent();
}

class FontSizeEvent extends NewsDetailEvent {
  final double fontSize;

  const FontSizeEvent(this.fontSize);
}

class FontSizeResetEvent extends NewsDetailEvent {}

class FontFamilyEvent extends NewsDetailEvent {
  final String fontFamily;

  const FontFamilyEvent(this.fontFamily);
}

class NewsEvent extends NewsDetailEvent {
  final News news;

  const NewsEvent(this.news);
}

class CommentEvent extends NewsDetailEvent {
  final List<Comment> comment;

  const CommentEvent(this.comment);
}

class IndexCommentEvent extends NewsDetailEvent {
  final int indexComment;

  const IndexCommentEvent(this.indexComment);
}

class HasReachedMaxCommentEvent extends NewsDetailEvent {
  final bool hasReachedMaxComment;

  const HasReachedMaxCommentEvent(this.hasReachedMaxComment);
}

class RelatedNewsEvent extends NewsDetailEvent {
  final List<News> relatedNews;

  const RelatedNewsEvent(this.relatedNews);
}
