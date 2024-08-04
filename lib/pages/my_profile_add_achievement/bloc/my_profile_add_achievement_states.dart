class MyProfileAddAchievementState {
  final String name;
  final String type;
  final String time;
  final bool isLoading;

  MyProfileAddAchievementState(
      {this.name = "",
      this.type = "",
      this.time = "",
      this.isLoading = false});

  MyProfileAddAchievementState copyWith(
      {String? name,
      String? type,
      String? time,
      bool? isLoading}) {
    return MyProfileAddAchievementState(
      name: name ?? this.name,
      type: type ?? this.type,
      time: time ?? this.time,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
