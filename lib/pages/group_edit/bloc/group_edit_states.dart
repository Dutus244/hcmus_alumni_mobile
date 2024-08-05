import 'dart:io';

class GroupEditState {
  final String name;
  final String description;
  final int privacy;
  final String networkPicture;
  final List<File> pictures;
  final List<String> tags;
  final bool isLoading;

  GroupEditState(
      {this.name = "",
      this.description = "",
      this.privacy = 0,
      this.networkPicture = "",
      this.pictures = const [],
      this.tags = const [],
      this.isLoading = false});

  GroupEditState copyWith({
    String? name,
    String? description,
    int? privacy,
    String? networkPicture,
    List<File>? pictures,
    List<String>? tags,
    bool? isLoading,
  }) {
    return GroupEditState(
      name: name ?? this.name,
      description: description ?? this.description,
      privacy: privacy ?? this.privacy,
      networkPicture: networkPicture ?? this.networkPicture,
      pictures: pictures ?? this.pictures,
      tags: tags ?? this.tags,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
