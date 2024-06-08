class Job {
  final int id;
  final String companyName;
  final String position;
  final String startTime;
  final String endTime;

  Job(this.id, this.companyName, this.position, this.startTime, this.endTime);

  Job.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        companyName = json["companyName"],
        position = json["position"],
        startTime = json["startTime"],
        endTime = json["endTime"];
}
