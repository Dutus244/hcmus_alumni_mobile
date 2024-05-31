import 'dart:io';

import 'package:hcmus_alumni_mobile/model/picture.dart';
import 'package:multi_dropdown/models/value_item.dart';

abstract class EditPostGroupEvent {
  const EditPostGroupEvent();
}

class TitleEvent extends EditPostGroupEvent {
  final String title;

  const TitleEvent(this.title);
}

class ContentEvent extends EditPostGroupEvent {
  final String content;

  const ContentEvent(this.content);
}

class TagsEvent extends EditPostGroupEvent {
  final List<String> tags;

  const TagsEvent(this.tags);
}

class ItemTagsEvent extends EditPostGroupEvent {
  final List<ValueItem> itemTags;

  const ItemTagsEvent(this.itemTags);
}

class PicturesEvent extends EditPostGroupEvent {
  final List<File> pictures;

  const PicturesEvent(this.pictures);
}

class DeletePicturesEvent extends EditPostGroupEvent {
  final List<String> deletePictures;

  const DeletePicturesEvent(this.deletePictures);
}

class PictureNetworksEvent extends EditPostGroupEvent {
  final List<Picture> pictureNetworks;

  const PictureNetworksEvent(this.pictureNetworks);
}

class PageEvent extends EditPostGroupEvent {
  final int page;

  const PageEvent(this.page);
}

class EditPostGroupResetEvent extends EditPostGroupEvent {}
