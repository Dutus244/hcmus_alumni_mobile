import 'package:hcmus_alumni_mobile/model/job.dart';

class JobResponse {
  final List<Job> jobs;

  JobResponse(this.jobs);

  JobResponse.fromJson(Map<String, dynamic> json)
      : jobs = (json["jobs"] as List).map((i) => new Job.fromJson(i)).toList();
}
