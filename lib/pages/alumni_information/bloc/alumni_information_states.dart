import 'dart:io';

class AlumniInformationState {
  final File? avatar;
  final String fullName;

  const AlumniInformationState({
    this.avatar,
    this.fullName = "",
  });

  AlumniInformationState copyWith({File? avatar, String? fullName}) {
    return AlumniInformationState(
      avatar: avatar ?? this.avatar,
      fullName: fullName ?? this.fullName,
    );
  }
}
