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

class VotesEvent extends WritePostAdviseEvent {
  final List<String> votes;

  const VotesEvent(this.votes);
}

class PicturesEvent extends WritePostAdviseEvent {
  final List<File> pictures;

  const PicturesEvent(this.pictures);
}

class PageEvent extends WritePostAdviseEvent {
  final int page;

  const PageEvent(this.page);
}

class AllowMultipleVotesEvent extends WritePostAdviseEvent {
  final bool allowMultipleVotes;

  const AllowMultipleVotesEvent(this.allowMultipleVotes);
}

class AllowAddOptionsEvent extends WritePostAdviseEvent {
  final bool allowAddOptions;

  const AllowAddOptionsEvent(this.allowAddOptions);
}

class IsLoadingEvent extends WritePostAdviseEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class WritePostAdviseResetEvent extends WritePostAdviseEvent {}
