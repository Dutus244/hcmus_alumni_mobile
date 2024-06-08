import 'package:hcmus_alumni_mobile/model/education.dart';

class EducationResponse {
  final List<Education> educations;

  EducationResponse(this.educations);

  EducationResponse.fromJson(Map<String, dynamic> json)
      : educations = (json["educations"] as List)
            .map((i) => new Education.fromJson(i))
            .toList();
}
