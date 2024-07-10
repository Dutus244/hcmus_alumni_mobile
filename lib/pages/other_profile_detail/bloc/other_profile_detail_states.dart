import 'package:hcmus_alumni_mobile/model/alumni.dart';
import 'package:hcmus_alumni_mobile/model/alumni_verification.dart';

import '../../../model/achievement.dart';
import '../../../model/education.dart';
import '../../../model/event.dart';
import '../../../model/friend.dart';
import '../../../model/job.dart';
import '../../../model/user.dart';

enum Status { loading, success }

class OtherProfileDetailState {
  final User? user;
  final AlumniVerification? alumniVerification;
  final Alumni? alumni;
  final List<Education> educations;
  final List<Job> jobs;
  final List<Achievement> achievements;

  OtherProfileDetailState({
    this.user,
    this.alumniVerification,
    this.alumni,
    this.educations = const [],
    this.jobs = const [],
    this.achievements = const [],
  });

  OtherProfileDetailState copyWith({
    User? user,
    AlumniVerification? alumniVerification,
    Alumni? alumni,
    List<Education>? educations,
    List<Job>? jobs,
    List<Achievement>? achievements,
  }) {
    return OtherProfileDetailState(
      user: user ?? this.user,
      alumniVerification: alumniVerification ?? this.alumniVerification,
      alumni: alumni ?? this.alumni,
      educations: educations ?? this.educations,
      jobs: jobs ?? this.jobs,
      achievements: achievements ?? this.achievements,
    );
  }
}
