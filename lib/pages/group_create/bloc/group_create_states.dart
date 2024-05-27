import 'dart:io';

class GroupCreateState {
  final String name;
  final String description;
  final int privacy;
  final List<File> pictures;

  GroupCreateState(
      {this.name = "",
      this.description = "",
      this.privacy = 0,
      this.pictures = const []});

  GroupCreateState copyWith({
    String? name,
    String? description,
    int? privacy,
    List<File>? pictures,
  }) {
    return GroupCreateState(
      name: name ?? this.name,
      description: description ?? this.description,
      privacy: privacy ?? this.privacy,
      pictures: pictures ?? this.pictures,
    );
  }
}
