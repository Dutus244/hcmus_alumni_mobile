import 'dart:io';

abstract class WritePostGroupEvent {
  const WritePostGroupEvent();
}

class TitleEvent extends WritePostGroupEvent {
  final String title;

  const TitleEvent(this.title);
}

class ContentEvent extends WritePostGroupEvent {
  final String content;

  const ContentEvent(this.content);
}

class TagsEvent extends WritePostGroupEvent {
  final List<String> tags;

  const TagsEvent(this.tags);
}

class VotesEvent extends WritePostGroupEvent {
  final List<String> votes;

  const VotesEvent(this.votes);
}

class PicturesEvent extends WritePostGroupEvent {
  final List<File> pictures;

  const PicturesEvent(this.pictures);
}

class PageEvent extends WritePostGroupEvent {
  final int page;

  const PageEvent(this.page);
}

class WritePostGroupResetEvent extends WritePostGroupEvent {}
