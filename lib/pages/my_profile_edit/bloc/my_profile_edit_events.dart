import 'dart:io';

import 'package:hcmus_alumni_mobile/model/achievement.dart';
import 'package:hcmus_alumni_mobile/model/education.dart';
import 'package:hcmus_alumni_mobile/model/job.dart';

import '../../../model/alumni.dart';
import '../../../model/alumni_verification.dart';
import '../../../model/user.dart';

class MyProfileEditEvent {
  const MyProfileEditEvent();
}

class UserEvent extends MyProfileEditEvent {
  final User user;

  const UserEvent(this.user);
}

class FullNameEvent extends MyProfileEditEvent {
  final String fullName;

  const FullNameEvent(this.fullName);
}

class PhoneEvent extends MyProfileEditEvent {
  final String phone;

  const PhoneEvent(this.phone);
}

class EmailEvent extends MyProfileEditEvent {
  final String email;

  const EmailEvent(this.email);
}

class FacultyIdEvent extends MyProfileEditEvent {
  final int facultyId;

  const FacultyIdEvent(this.facultyId);
}

class SexEvent extends MyProfileEditEvent {
  final String sex;

  const SexEvent(this.sex);
}

class DobEvent extends MyProfileEditEvent {
  final String dob;

  const DobEvent(this.dob);
}

class SocialLinkEvent extends MyProfileEditEvent {
  final String socialLink;

  const SocialLinkEvent(this.socialLink);
}

class AboutMeEvent extends MyProfileEditEvent {
  final String aboutMe;

  const AboutMeEvent(this.aboutMe);
}

class ClasssEvent extends MyProfileEditEvent {
  final String classs;

  const ClasssEvent(this.classs);
}

class StudentIdEvent extends MyProfileEditEvent {
  final String studentId;

  const StudentIdEvent(this.studentId);
}

class StartYearEvent extends MyProfileEditEvent {
  final String startYear;

  const StartYearEvent(this.startYear);
}

class EndYearEvent extends MyProfileEditEvent {
  final String endYear;

  const EndYearEvent(this.endYear);
}

class NetworkAvatarEvent extends MyProfileEditEvent {
  final String networkAvatar;

  const NetworkAvatarEvent(this.networkAvatar);
}

class NetworkCoverEvent extends MyProfileEditEvent {
  final String networkCover;

  const NetworkCoverEvent(this.networkCover);
}

class StatusEvent extends MyProfileEditEvent {
  final String status;

  const StatusEvent(this.status);
}

class AvatarEvent extends MyProfileEditEvent {
  final File avatar;

  const AvatarEvent(this.avatar);
}

class CoverEvent extends MyProfileEditEvent {
  final List<File> cover;

  const CoverEvent(this.cover);
}

class JobsEvent extends MyProfileEditEvent {
  final List<Job> jobs;

  const JobsEvent(this.jobs);
}

class EducationsEvent extends MyProfileEditEvent {
  final List<Education> educations;

  const EducationsEvent(this.educations);
}

class AchievementsEvent extends MyProfileEditEvent {
  final List<Achievement> achievements;

  const AchievementsEvent(this.achievements);
}

class UpdateProfileEvent extends MyProfileEditEvent {
  final User user;

  const UpdateProfileEvent(this.user);
}

class UpdateAlumniVerEvent extends MyProfileEditEvent {
  final AlumniVerification alumniVerification;

  const UpdateAlumniVerEvent(this.alumniVerification);
}

class UpdateAlumniEvent extends MyProfileEditEvent {
  final Alumni alumni;

  const UpdateAlumniEvent(this.alumni);
}

class IsLoadingEvent extends MyProfileEditEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class MyProfileEditResetEvent extends MyProfileEditEvent {}