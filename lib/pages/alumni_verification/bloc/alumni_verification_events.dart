abstract class AlumniVerificationEvent {
  const AlumniVerificationEvent();
}

class SocialMediaLinkEvent extends AlumniVerificationEvent {
  final String socialMediaLink;

  const SocialMediaLinkEvent(this.socialMediaLink);
}

class StudentIdEvent extends AlumniVerificationEvent {
  final String studentId;

  const StudentIdEvent(this.studentId);
}

class StartYearEvent extends AlumniVerificationEvent {
  final int startYear;

  const StartYearEvent(this.startYear);
}

class AlumniVerificationResetEvent extends AlumniVerificationEvent {}
