import 'dart:io';

abstract class WritePostAdviseEvent {
  const WritePostAdviseEvent();
}

class TitleEvent extends WritePostAdviseEvent {
  final String title;

  const TitleEvent(this.title);
}

class ContentEvent extends WritePostAdviseEvent {
  final String content;

  const ContentEvent(this.content);
}

class TagsEvent extends WritePostAdviseEvent {
  final List<String> tags;

  const TagsEvent(this.tags);
}

class PicturesEvent extends WritePostAdviseEvent {
  final List<File> pictures;

  const PicturesEvent(this.pictures);
}

class PageEvent extends WritePostAdviseEvent {
  final int page;

  const PageEvent(this.page);
}

class WritePostAdviseResetEvent extends WritePostAdviseEvent {}
