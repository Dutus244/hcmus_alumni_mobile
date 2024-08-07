import 'dart:io';

import 'package:hcmus_alumni_mobile/model/picture.dart';
import 'package:multi_dropdown/models/value_item.dart';

abstract class EditPostAdviseEvent {
  const EditPostAdviseEvent();
}

class TitleEvent extends EditPostAdviseEvent {
  final String title;

  const TitleEvent(this.title);
}

class ContentEvent extends EditPostAdviseEvent {
  final String content;

  const ContentEvent(this.content);
}

class TagsEvent extends EditPostAdviseEvent {
  final List<String> tags;

  const TagsEvent(this.tags);
}

class PicturesEvent extends EditPostAdviseEvent {
  final List<File> pictures;

  const PicturesEvent(this.pictures);
}

class DeletePicturesEvent extends EditPostAdviseEvent {
  final List<String> deletePictures;

  const DeletePicturesEvent(this.deletePictures);
}

class PictureNetworksEvent extends EditPostAdviseEvent {
  final List<Picture> pictureNetworks;

  const PictureNetworksEvent(this.pictureNetworks);
}

class PageEvent extends EditPostAdviseEvent {
  final int page;

  const PageEvent(this.page);
}

class IsLoadingEvent extends EditPostAdviseEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class EditPostAdviseResetEvent extends EditPostAdviseEvent {}
