class MyProfileAddJobEvent {
  const MyProfileAddJobEvent();
}

class CompanyNameEvent extends MyProfileAddJobEvent {
  final String comapyName;

  const CompanyNameEvent(this.comapyName);
}

class PositionEvent extends MyProfileAddJobEvent {
  final String position;

  const PositionEvent(this.position);
}

class StartTimeEvent extends MyProfileAddJobEvent {
  final String startTime;

  const StartTimeEvent(this.startTime);
}

class IsWorkingEvent extends MyProfileAddJobEvent {
  final bool isWorking;

  const IsWorkingEvent(this.isWorking);
}

class EndTimeEvent extends MyProfileAddJobEvent {
  final String endTime;

  const EndTimeEvent(this.endTime);
}

class MyProfileAddJobResetEvent extends MyProfileAddJobEvent {}