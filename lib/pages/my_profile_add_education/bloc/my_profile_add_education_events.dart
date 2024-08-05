class MyProfileAddEducationEvent {
  const MyProfileAddEducationEvent();
}

class SchoolNameEvent extends MyProfileAddEducationEvent {
  final String schoolName;

  const SchoolNameEvent(this.schoolName);
}

class DegreeEvent extends MyProfileAddEducationEvent {
  final String degree;

  const DegreeEvent(this.degree);
}

class StartTimeEvent extends MyProfileAddEducationEvent {
  final String startTime;

  const StartTimeEvent(this.startTime);
}

class IsStudyingEvent extends MyProfileAddEducationEvent {
  final bool isStudying;

  const IsStudyingEvent(this.isStudying);
}

class EndTimeEvent extends MyProfileAddEducationEvent {
  final String endTime;

  const EndTimeEvent(this.endTime);
}

class IsLoadingEvent extends MyProfileAddEducationEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class MyProfileAddEducationResetEvent extends MyProfileAddEducationEvent {}