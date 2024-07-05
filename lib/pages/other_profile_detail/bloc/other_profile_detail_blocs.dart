import 'package:flutter_bloc/flutter_bloc.dart';

import 'other_profile_detail_events.dart';
import 'other_profile_detail_states.dart';

class OtherProfileDetailBloc
    extends Bloc<OtherProfileDetailEvent, OtherProfileDetailState> {
  OtherProfileDetailBloc() : super(OtherProfileDetailState()) {
    on<UserEvent>(_userEvent);
    on<AlumniVerificationEvent>(_alumniVerificationEvent);
    on<AlumniEvent>(_alumniEvent);
    on<EducationsEvent>(_educationsEvent);
    on<JobsEvent>(_jobsEvent);
    on<AchievementsEvent>(_achievementsEvent);
  }

  void _userEvent(UserEvent event, Emitter<OtherProfileDetailState> emit) {
    emit(state.copyWith(user: event.user));
  }

  void _alumniVerificationEvent(
      AlumniVerificationEvent event, Emitter<OtherProfileDetailState> emit) {
    emit(state.copyWith(alumniVerification: event.alumniVerification));
  }

  void _alumniEvent(AlumniEvent event, Emitter<OtherProfileDetailState> emit) {
    emit(state.copyWith(alumni: event.alumni));
  }

  void _educationsEvent(
      EducationsEvent event, Emitter<OtherProfileDetailState> emit) async {
    emit(state.copyWith(educations: event.educations));
  }

  void _jobsEvent(
      JobsEvent event, Emitter<OtherProfileDetailState> emit) async {
    emit(state.copyWith(jobs: event.jobs));
  }

  void _achievementsEvent(
      AchievementsEvent event, Emitter<OtherProfileDetailState> emit) async {
    emit(state.copyWith(achievements: event.achievements));
  }
}
