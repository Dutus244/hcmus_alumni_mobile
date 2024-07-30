import 'dart:io';

abstract class AlumniInformationEvent {
  const AlumniInformationEvent();
}

class AvatarEvent extends AlumniInformationEvent {
  final File avatar;

  const AvatarEvent(this.avatar);
}

class FullNameEvent extends AlumniInformationEvent {
  final String fullName;

  const FullNameEvent(this.fullName);
}

class AlumniInformationResetEvent extends AlumniInformationEvent {}
