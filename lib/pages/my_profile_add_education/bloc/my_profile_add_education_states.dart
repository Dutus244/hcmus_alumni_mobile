class MyProfileAddEducationState {
  final String schoolName;
  final String degree;
  final String startTime;
  final bool isStudying;
  final String endTime;
  final bool isLoading;

  MyProfileAddEducationState(
      {this.schoolName = "",
      this.degree = "",
      this.isStudying = false,
      this.startTime = "",
      this.endTime = "",
      this.isLoading = false});

  MyProfileAddEducationState copyWith(
      {String? schoolName,
      String? degree,
      String? startTime,
      bool? isStudying,
      String? endTime,
      bool? isLoading}) {
    return MyProfileAddEducationState(
      schoolName: schoolName ?? this.schoolName,
      degree: degree ?? this.degree,
      startTime: startTime ?? this.startTime,
      isStudying: isStudying ?? this.isStudying,
      endTime: endTime ?? this.endTime,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
