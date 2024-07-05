import 'package:intl/intl.dart';

class Job {
  final String id;
  final String companyName;
  final String position;
  final String startTime;
  final String endTime;
  final bool isWorking;

  Job(this.id, this.companyName, this.position, this.startTime, this.endTime, this.isWorking);

  Job.fromJson(Map<String, dynamic> json)
      : id = json["jobId"],
        companyName = json["companyName"],
        position = json["position"],
        startTime = json["startTime"] != null ? DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(json["startTime"]).add(Duration(days: 1))) : '',
        endTime = json["endTime"] != null ? DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(json["endTime"]).add(Duration(days: 1))) : '',
        isWorking = json["isWorking"] != null ? json["isWorking"] : false;
}
