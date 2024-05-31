import 'dart:io';

class WritePostGroupState {
  final String title;
  final String content;
  final List<String> tags;
  List<String> votes;
  final List<File> pictures;
  final int page;

  WritePostGroupState(
      {this.title = "",
      this.content = "",
      this.tags = const [],
      this.votes = const [],
      this.pictures = const [],
      this.page = 0});

  WritePostGroupState copyWith(
      {String? title,
      String? content,
      List<String>? tags,
      List<String>? votes,
      List<File>? pictures,
      int? page}) {
    return WritePostGroupState(
      title: title ?? this.title,
      content: content ?? this.content,
      tags: tags ?? this.tags,
      votes: votes ?? this.votes,
      pictures: pictures ?? this.pictures,
      page: page ?? this.page,
    );
  }
}
