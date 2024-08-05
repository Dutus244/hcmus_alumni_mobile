class MyProfileAddJobState {
  final String companyName;
  final String position;
  final String startTime;
  final bool isWorking;
  final String endTime;
  final bool isLoading;

  MyProfileAddJobState(
      {this.companyName = "",
      this.position = "",
      this.isWorking = false,
      this.startTime = "",
      this.endTime = "",
      this.isLoading = false});

  MyProfileAddJobState copyWith(
      {String? companyName,
      String? position,
      String? startTime,
      bool? isWorking,
      String? endTime,
      bool? isLoading}) {
    return MyProfileAddJobState(
      companyName: companyName ?? this.companyName,
      position: position ?? this.position,
      startTime: startTime ?? this.startTime,
      isWorking: isWorking ?? this.isWorking,
      endTime: endTime ?? this.endTime,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
