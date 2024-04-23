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

class GraduationYearEvent extends HofPageEvent {
  final String graduationYear;

  const GraduationYearEvent(this.graduationYear);
}

class ClearFilterEvent extends HofPageEvent {}

class HofPageResetEvent extends HofPageEvent {}
