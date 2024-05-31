import 'dart:io';

class WritePostAdviseState {
  final String title;
  final String content;
  final List<String> tags;
  List<String> votes;
  final List<File> pictures;
  final int page;

  WritePostAdviseState(
      {this.title = "",
      this.content = "",
      this.tags = const [],
      this.votes = const [],
      this.pictures = const [],
      this.page = 0});

  WritePostAdviseState copyWith(
      {String? title,
      String? content,
      List<String>? tags,
      List<String>? votes,
      List<File>? pictures,
      int? page}) {
    return WritePostAdviseState(
      title: title ?? this.title,
      content: content ?? this.content,
      tags: tags ?? this.tags,
      votes: votes ?? this.votes,
      pictures: pictures ?? this.pictures,
      page: page ?? this.page,
    );
  }
}
