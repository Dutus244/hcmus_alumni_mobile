import 'package:hcmus_alumni_mobile/model/faculty.dart';

class User {
  final String id;
  final String email;
  final String fullName;
  final String phone;
  final String sex;
  final String dob;
  final String socialLink;
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
      this.socialLink,
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
        sex = json["sex"] ?? "",
        dob = json["dob"] ?? "",
        socialLink = json["socialLink"] ?? "",
        faculty = json["faculty"] != null ? Faculty.fromJson(json["faculty"]) : null,
        degree = json["degree"] ?? "",
        aboutMe = json["aboutMe"] ?? "",
        avatarUrl = json["avatarUrl"] ?? "",
        coverUrl = json["coverUrl"] ?? "";
}
