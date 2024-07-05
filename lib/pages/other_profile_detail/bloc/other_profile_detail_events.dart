import 'package:hcmus_alumni_mobile/model/event.dart';

import '../../../model/achievement.dart';
import '../../../model/alumni.dart';
import '../../../model/alumni_verification.dart';
import '../../../model/education.dart';
import '../../../model/friend.dart';
import '../../../model/job.dart';
import '../../../model/post.dart';
import '../../../model/user.dart';
import 'other_profile_detail_states.dart';

class OtherProfileDetailEvent {
  const OtherProfileDetailEvent();
}

class UserEvent extends OtherProfileDetailEvent {
  final User user;

  const UserEvent(this.user);
}

class AlumniVerificationEvent extends OtherProfileDetailEvent {
  final AlumniVerification alumniVerification;

  const AlumniVerificationEvent(this.alumniVerification);
}

class AlumniEvent extends OtherProfileDetailEvent {
  final Alumni alumni;

  const AlumniEvent(this.alumni);
}

class EducationsEvent extends OtherProfileDetailEvent {
  final List<Education> educations;

  const EducationsEvent(this.educations);
}

class JobsEvent extends OtherProfileDetailEvent {
  final List<Job> jobs;

  const JobsEvent(this.jobs);
}

class AchievementsEvent extends OtherProfileDetailEvent {
  final List<Achievement> achievements;

  const AchievementsEvent(this.achievements);
}