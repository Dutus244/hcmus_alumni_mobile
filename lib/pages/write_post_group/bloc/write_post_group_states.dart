import 'dart:io';

class WritePostGroupState {
  final String title;
  final String content;
  final List<String> tags;
  List<String> votes;
  final List<File> pictures;
  final int page;
  final bool allowMultipleVotes;
  final bool allowAddOptions;
  final bool isLoading;

  WritePostGroupState(
      {this.title = "",
      this.content = "",
      this.tags = const [],
      this.votes = const [],
      this.pictures = const [],
      this.page = 0,
      this.allowMultipleVotes = false,
      this.allowAddOptions = false,
      this.isLoading = false});

  WritePostGroupState copyWith(
      {String? title,
      String? content,
      List<String>? tags,
      List<String>? votes,
      List<File>? pictures,
      int? page,
      bool? allowMultipleVotes,
      bool? allowAddOptions,
      bool? isLoading}) {
    return WritePostGroupState(
      title: title ?? this.title,
      content: content ?? this.content,
      tags: tags ?? this.tags,
      votes: votes ?? this.votes,
      pictures: pictures ?? this.pictures,
      page: page ?? this.page,
      allowAddOptions: allowAddOptions ?? this.allowAddOptions,
      allowMultipleVotes: allowMultipleVotes ?? this.allowMultipleVotes,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
