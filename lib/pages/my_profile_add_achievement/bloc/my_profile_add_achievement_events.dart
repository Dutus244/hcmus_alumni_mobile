class MyProfileAddAchievementEvent {
  const MyProfileAddAchievementEvent();
}

class NameEvent extends MyProfileAddAchievementEvent {
  final String name;

  const NameEvent(this.name);
}

class TypeEvent extends MyProfileAddAchievementEvent {
  final String type;

  const TypeEvent(this.type);
}

class TimeEvent extends MyProfileAddAchievementEvent {
  final String time;

  const TimeEvent(this.time);
}

class IsLoadingEvent extends MyProfileAddAchievementEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class MyProfileAddAchievementResetEvent extends MyProfileAddAchievementEvent {}