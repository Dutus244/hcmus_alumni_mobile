import 'dart:io';

import 'package:hcmus_alumni_mobile/model/picture.dart';
import 'package:multi_dropdown/models/value_item.dart';

class EditPostAdviseState {
  final String title;
  final String content;
  final List<String> tags;
  final List<ValueItem> itemTags;
  final List<Picture> pictureNetworks;
  final List<File> pictures;
  final List<String> deletePictures;
  final int page;

  EditPostAdviseState(
      {this.title = "",
      this.content = "",
      this.tags = const [],
      this.itemTags = const [],
      this.pictureNetworks = const [],
      this.pictures = const [],
      this.deletePictures = const [],
      this.page = 0});

  EditPostAdviseState copyWith(
      {String? title,
      String? content,
      List<String>? tags,
      List<ValueItem>? itemTags,
      List<Picture>? pictureNetworks,
      List<String>? deletePictures,
      List<File>? pictures,
      int? page}) {
    return EditPostAdviseState(
      title: title ?? this.title,
      content: content ?? this.content,
      tags: tags ?? this.tags,
      itemTags: itemTags ?? this.itemTags,
      pictureNetworks: pictureNetworks ?? this.pictureNetworks,
      pictures: pictures ?? this.pictures,
      deletePictures: deletePictures ?? this.deletePictures,
      page: page ?? this.page,
    );
  }
}
