abstract class AlumniVerificationEvent {
  const AlumniVerificationEvent();
}

class FullNameEvent extends AlumniVerificationEvent {
  final String fullName;

  const FullNameEvent(this.fullName);
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
