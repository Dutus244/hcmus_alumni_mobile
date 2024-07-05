class AlumniVerification {
  final String? status;
  final String? studentId;
  final int? beginningYear;

  AlumniVerification(this.status, this.studentId, this.beginningYear);

  AlumniVerification.fromJson(Map<String, dynamic> json)
      : status = json["status"],
        studentId = json["studentId"],
        beginningYear = json["beginningYear"];
}
