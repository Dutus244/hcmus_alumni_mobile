import 'dart:io';

class GroupEditState {
  final String name;
  final String description;
  final int privacy;
  final String networkPicture;
  final List<File> pictures;

  GroupEditState(
      {this.name = "",
        this.description = "",
        this.privacy = 0,
        this.networkPicture = "",
        this.pictures = const []});

  GroupEditState copyWith({
    String? name,
    String? description,
    int? privacy,
    String? networkPicture,
    List<File>? pictures,
  }) {
    return GroupEditState(
      name: name ?? this.name,
      description: description ?? this.description,
      privacy: privacy ?? this.privacy,
      networkPicture: networkPicture ?? this.networkPicture,
      pictures: pictures ?? this.pictures,
    );
  }
}