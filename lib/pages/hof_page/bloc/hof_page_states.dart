class HofPageState {
  final String name;
  final String faculty;
  final String graduationYear;

  const HofPageState({
    this.name = "",
    this.faculty = "",
    this.graduationYear = "",
  });

  HofPageState copyWith(
      {String? name, String? faculty, String? graduationYear}) {
    return HofPageState(
      name: name ?? this.name,
      faculty: faculty ?? this.faculty,
      graduationYear: graduationYear ?? this.graduationYear,
    );
  }
}
