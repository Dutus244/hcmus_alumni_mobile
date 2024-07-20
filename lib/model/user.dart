import 'package:hcmus_alumni_mobile/model/faculty.dart';
import 'package:hcmus_alumni_mobile/model/sex.dart';
import 'package:intl/intl.dart';

class User {
  final String id;
  final String email;
  final String fullName;
  final String phone;
  final Sex? sex;
  final String dob;
  final String socialMediaLink;
  final Faculty? faculty;
  final String degree;
  final String aboutMe;
  final String avatarUrl;
  final String coverUrl;

  User(
      this.id,
      this.email,
      this.fullName,
      this.phone,
      this.sex,
      this.dob,
      this.socialMediaLink,
      this.faculty,
      this.degree,
      this.aboutMe,
      this.avatarUrl,
      this.coverUrl);

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? "",
        email = json["email"] ?? "",
        fullName = json["fullName"] ?? "",
        phone = json["phone"] ?? "",
        sex = json["sex"] != null ? Sex.fromJson(json["sex"]) : null,
        dob = json["dob"] != null ? DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(json["dob"]).add(Duration(days: 1))) : '',
        socialMediaLink = json["socialMediaLink"] ?? "",
        faculty =
            json["faculty"] != null ? Faculty.fromJson(json["faculty"]) : null,
        degree = json["degree"] ?? "",
        aboutMe = json["aboutMe"] ?? "",
        avatarUrl = json["avatarUrl"] ?? "",
        coverUrl = json["coverUrl"] ?? "";
}
