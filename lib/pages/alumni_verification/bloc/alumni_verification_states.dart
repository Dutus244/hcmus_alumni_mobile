class AlumniVerificationState {
  final String socialMediaLink;
  final String studentId;
  final int startYear;

  const AlumniVerificationState({
    this.socialMediaLink = "",
    this.studentId = "",
    this.startYear = 0,
  });

  AlumniVerificationState copyWith(
      {String? socialMediaLink, String? studentId, int? startYear}) {
    return AlumniVerificationState(
      socialMediaLink: socialMediaLink ?? this.socialMediaLink,
      studentId: studentId ?? this.studentId,
      startYear: startYear ?? this.startYear,
    );
  }
}
