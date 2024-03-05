class AlumniVerificationState {
  final String fullName;
  final String studentId;
  final int startYear;

  const AlumniVerificationState({
    this.fullName = "",
    this.studentId = "",
    this.startYear = 2000,
  });

  AlumniVerificationState copyWith(
      {String? fullName, String? studentId, int? startYear}) {
    return AlumniVerificationState(
      fullName: fullName ?? this.fullName,
      studentId: studentId ?? this.studentId,
      startYear: startYear ?? this.startYear,
    );
  }
}
