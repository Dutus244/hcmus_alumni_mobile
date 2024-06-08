class MyProfileAddEducationState {
  final String schoolName;
  final String degree;
  final String startTime;
  final bool isStudying;
  final String endTime;

  MyProfileAddEducationState(
      {this.schoolName = "",
      this.degree = "",
      this.isStudying = false,
      this.startTime = "",
      this.endTime = ""});

  MyProfileAddEducationState copyWith(
      {String? schoolName,
      String? degree,
      String? startTime,
      bool? isStudying,
      String? endTime}) {
    return MyProfileAddEducationState(
      schoolName: schoolName ?? this.schoolName,
      degree: degree ?? this.degree,
      startTime: startTime ?? this.startTime,
      isStudying: isStudying ?? this.isStudying,
      endTime: endTime ?? this.endTime,
    );
  }
}
