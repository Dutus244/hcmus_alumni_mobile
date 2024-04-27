import 'package:hcmus_alumni_mobile/model/hall_of_fame.dart';
import 'package:hcmus_alumni_mobile/pages/hof_page/bloc/hof_page_states.dart';

abstract class HofPageEvent {
  const HofPageEvent();
}

class NameEvent extends HofPageEvent {
  final String name;

  const NameEvent(this.name);
}

class FacultyEvent extends HofPageEvent {
  final String faculty;

  const FacultyEvent(this.faculty);
}

class BeginningYearEvent extends HofPageEvent {
  final String beginningYear;

  const BeginningYearEvent(this.beginningYear);
}

class NameSearchEvent extends HofPageEvent {
  final String nameSearch;

  const NameSearchEvent(this.nameSearch);
}

class FacultySearchEvent extends HofPageEvent {
  final String facultySearch;

  const FacultySearchEvent(this.facultySearch);
}

class BeginningYearSearchEvent extends HofPageEvent {
  final String beginningYearSearch;

  const BeginningYearSearchEvent(this.beginningYearSearch);
}

class StatusHofEvent extends HofPageEvent {
  final Status statusHof;

  const StatusHofEvent(this.statusHof);
}

class HallOfFameEvent extends HofPageEvent {
  final List<HallOfFame> hallOfFame;

  const HallOfFameEvent(this.hallOfFame);
}

class IndexHofEvent extends HofPageEvent {
  final int indexHof;

  const IndexHofEvent(this.indexHof);
}

class HasReachedMaxHofEvent extends HofPageEvent {
  final bool hasReachedMaxHof;

  const HasReachedMaxHofEvent(this.hasReachedMaxHof);
}

class ClearFilterEvent extends HofPageEvent {}

class ClearResultEvent extends HofPageEvent {}

class HofPageResetEvent extends HofPageEvent {}
