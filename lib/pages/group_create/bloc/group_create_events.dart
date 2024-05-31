import 'dart:io';

abstract class GroupCreateEvent {
  const GroupCreateEvent();
}

class NameEvent extends GroupCreateEvent {
  final String name;

  const NameEvent(this.name);
}

class DescriptionEvent extends GroupCreateEvent {
  final String description;

  const DescriptionEvent(this.description);
}

class PrivacyEvent extends GroupCreateEvent {
  final int privacy;

  const PrivacyEvent(this.privacy);
}

class PicturesEvent extends GroupCreateEvent {
  final List<File> pictures;

  const PicturesEvent(this.pictures);
}

class TagsEvent extends GroupCreateEvent {
  final List<String> tags;

  const TagsEvent(this.tags);
}

class GroupCreateResetEvent extends GroupCreateEvent {}