class AlumniVerificationState {
  final String socialMediaLink;
  final String studentId;
  final int startYear;
  final int facultyId;
  final bool isLoading;

  const AlumniVerificationState({
    this.socialMediaLink = "",
    this.studentId = "",
    this.startYear = 0,
    this.facultyId = 0,
    this.isLoading = false,
  });

  AlumniVerificationState copyWith(
      {String? socialMediaLink, String? studentId, int? startYear, int? facultyId, bool? isLoading}) {
    return AlumniVerificationState(
      socialMediaLink: socialMediaLink ?? this.socialMediaLink,
      studentId: studentId ?? this.studentId,
      startYear: startYear ?? this.startYear,
      facultyId: facultyId ?? this.facultyId,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
