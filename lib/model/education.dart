class Education {
  final String schoolName;
  final String degree;
  final String startTime;
  final String endTime;

  Education(this.schoolName, this.degree, this.startTime, this.endTime);

  Education.fromJson(Map<String, dynamic> json)
      : schoolName = json["schoolName"],
        degree = json["degree"],
        startTime = json["startTime"],
        endTime = json["endTime"];
}