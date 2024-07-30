class MyProfileAddAchievementState {
  final String name;
  final String type;
  final String time;

  MyProfileAddAchievementState(
      {this.name = "",
      this.type = "",
      this.time = ""});

  MyProfileAddAchievementState copyWith(
      {String? name,
      String? type,
      String? time}) {
    return MyProfileAddAchievementState(
      name: name ?? this.name,
      type: type ?? this.type,
      time: time ?? this.time,
    );
  }
}
