import 'package:intl/intl.dart';

class Education {
  final String id;
  final String schoolName;
  final String degree;
  final String startTime;
  final String endTime;
  final bool isLearning;

  Education(this.id, this.schoolName, this.degree, this.startTime, this.endTime,
      this.isLearning);

  Education.fromJson(Map<String, dynamic> json)
      : id = json["educationId"],
        schoolName = json["schoolName"],
        degree = json["degree"],
        startTime = json["startTime"] != null ? DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(json["startTime"]).add(Duration(days: 1))) : '',
        endTime = json["endTime"] != null ? DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(json["endTime"]).add(Duration(days: 1))) : '',
        isLearning = json["isLearning"] != null ? json["isLearning"] : false;
}
