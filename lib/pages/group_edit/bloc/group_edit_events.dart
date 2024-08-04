import 'dart:io';

abstract class GroupEditEvent {
  const GroupEditEvent();
}

class NameEvent extends GroupEditEvent {
  final String name;

  const NameEvent(this.name);
}

class DescriptionEvent extends GroupEditEvent {
  final String description;

  const DescriptionEvent(this.description);
}

class PrivacyEvent extends GroupEditEvent {
  final int privacy;

  const PrivacyEvent(this.privacy);
}

class NetworkPictureEvent extends GroupEditEvent {
  final String networkPicture;

  const NetworkPictureEvent(this.networkPicture);
}

class PicturesEvent extends GroupEditEvent {
  final List<File> pictures;

  const PicturesEvent(this.pictures);
}

class TagsEvent extends GroupEditEvent {
  final List<String> tags;

  const TagsEvent(this.tags);
}

class IsLoadingEvent extends GroupEditEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class GroupEditResetEvent extends GroupEditEvent {}