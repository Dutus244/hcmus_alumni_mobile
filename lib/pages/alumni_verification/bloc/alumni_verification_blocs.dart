import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_verification/bloc/alumni_verification_events.dart';

import 'alumni_verification_states.dart';

class AlumniVerificationBloc
    extends Bloc<AlumniVerificationEvent, AlumniVerificationState> {
  AlumniVerificationBloc() : super(AlumniVerificationState()) {
    on<SocialMediaLinkEvent>(_socialMediaLinkEvent);
    on<StudentIdEvent>(_studentIdEvent);
    on<StartYearEvent>(_startYearEvent);
    on<FacultyIdEvent>(_facultyIdEvent);
    on<AlumniVerificationResetEvent>(_alumniVerificationResetEvent);
  }

  void _socialMediaLinkEvent(
      SocialMediaLinkEvent event, Emitter<AlumniVerificationState> emit) {
    emit(state.copyWith(socialMediaLink: event.socialMediaLink));
  }

  void _studentIdEvent(
      StudentIdEvent event, Emitter<AlumniVerificationState> emit) {
    emit(state.copyWith(studentId: event.studentId));
  }

  void _startYearEvent(
      StartYearEvent event, Emitter<AlumniVerificationState> emit) {
    emit(state.copyWith(startYear: event.startYear));
  }

  void _facultyIdEvent(
      FacultyIdEvent event, Emitter<AlumniVerificationState> emit) {
    emit(state.copyWith(facultyId: event.facultyId));
  }

  void _alumniVerificationResetEvent(AlumniVerificationResetEvent event,
      Emitter<AlumniVerificationState> emit) {
    emit(AlumniVerificationState()); // Reset the state to its initial state
  }
}
