import 'dart:io';

class GroupCreateState {
  final String name;
  final String description;
  final int privacy;
  final List<File> pictures;
  List<String> tags;
  final bool isLoading;

  GroupCreateState(
      {this.name = "",
      this.description = "",
      this.privacy = 0,
      this.pictures = const [],
      this.tags = const [],
      this.isLoading = false});

  GroupCreateState copyWith({
    String? name,
    String? description,
    int? privacy,
    List<File>? pictures,
    List<String>? tags,
    bool? isLoading,
  }) {
    return GroupCreateState(
      name: name ?? this.name,
      description: description ?? this.description,
      privacy: privacy ?? this.privacy,
      pictures: pictures ?? this.pictures,
      tags: tags ?? this.tags,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
