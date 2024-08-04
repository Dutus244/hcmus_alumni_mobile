import 'dart:io';

import '../../../model/achievement.dart';
import '../../../model/education.dart';
import '../../../model/job.dart';

class MyProfileEditState {
  final String fullName;
  final String phone;
  final String email;
  final int facultyId;
  final String sex;
  final String dob;
  final String socialLink;
  final String aboutMe;
  final String classs;
  final String studentId;
  final String startYear;
  final String endYear;
  final String networkAvatar;
  final String networkCover;
  final File? avatar;
  final List<File> cover;
  final List<Job> jobs;
  final List<Education> educations;
  final List<Achievement> achievements;
  final String status;
  final bool isLoading;

  MyProfileEditState(
      {this.fullName = "",
      this.phone = "",
      this.email = "",
      this.facultyId = 0,
      this.sex = "Nam",
      this.dob = "",
      this.socialLink = "",
      this.aboutMe = "",
      this.classs = "",
      this.studentId = "",
      this.startYear = "",
      this.endYear = "",
      this.networkAvatar = "",
      this.networkCover = "",
      this.avatar = null,
      this.cover = const [],
      this.jobs = const [],
      this.educations = const [],
      this.achievements = const [],
      this.status = "",
      this.isLoading = false});

  MyProfileEditState copyWith({
    String? fullName,
    String? phone,
    String? email,
    int? facultyId,
    String? sex,
    String? dob,
    String? socialLink,
    String? aboutMe,
    String? classs,
    String? studentId,
    String? startYear,
    String? endYear,
    String? networkAvatar,
    String? networkCover,
    File? avatar,
    List<File>? cover,
    List<Job>? jobs,
    List<Education>? educations,
    List<Achievement>? achievements,
    String? status,
    bool? isLoading,
  }) {
    return MyProfileEditState(
        fullName: fullName ?? this.fullName,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        facultyId: facultyId ?? this.facultyId,
        sex: sex ?? this.sex,
        dob: dob ?? this.dob,
        socialLink: socialLink ?? this.socialLink,
        aboutMe: aboutMe ?? this.aboutMe,
        classs: classs ?? this.classs,
        studentId: studentId ?? this.studentId,
        startYear: startYear ?? this.startYear,
        endYear: endYear ?? this.endYear,
        networkAvatar: networkAvatar ?? this.networkAvatar,
        networkCover: networkCover ?? this.networkCover,
        avatar: avatar ?? this.avatar,
        cover: cover ?? this.cover,
        jobs: jobs ?? this.jobs,
        educations: educations ?? this.educations,
        achievements: achievements ?? this.achievements,
        status: status ?? this.status,
        isLoading: isLoading ?? this.isLoading);
  }
}
