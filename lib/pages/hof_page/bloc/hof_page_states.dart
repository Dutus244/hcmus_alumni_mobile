import '../../../model/hall_of_fame.dart';

enum Status { loading, success }

class HofPageState {
  final String name;
  final String faculty;
  final String beginningYear;

  final String nameSearch;
  final String facultySearch;
  final String beginningYearSearch;

  final Status statusHof;
  final List<HallOfFame> hallOfFames;
  final int indexHof;
  final bool hasReachedMaxHof;

  const HofPageState({
    this.name = "",
    this.faculty = "",
    this.beginningYear = "",
    this.nameSearch = "",
    this.facultySearch = "",
    this.beginningYearSearch = "",
    this.statusHof = Status.loading,
    this.hallOfFames = const [],
    this.indexHof = 0,
    this.hasReachedMaxHof = false,
  });

  HofPageState copyWith({
    String? name,
    String? faculty,
    String? beginningYear,
    String? nameSearch,
    String? facultySearch,
    String? beginningYearSearch,
    Status? statusHof,
    List<HallOfFame>? hallOfFames,
    int? indexHof,
    bool? hasReachedMaxHof,
  }) {
    return HofPageState(
      name: name ?? this.name,
      faculty: faculty ?? this.faculty,
      beginningYear: beginningYear ?? this.beginningYear,
      nameSearch: nameSearch ?? this.nameSearch,
      facultySearch: facultySearch ?? this.facultySearch,
      beginningYearSearch: beginningYearSearch ?? this.beginningYearSearch,
      statusHof: statusHof ?? this.statusHof,
      hallOfFames: hallOfFames ?? this.hallOfFames,
      indexHof: indexHof ?? this.indexHof,
      hasReachedMaxHof: hasReachedMaxHof ?? this.hasReachedMaxHof,
    );
  }
}
