import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_verification/bloc/alumni_verification_events.dart';

import 'alumni_verification_states.dart';

class AlumniVerificationBloc extends Bloc<AlumniVerificationEvent, AlumniVerificationState> {
  AlumniVerificationBloc() : super(AlumniVerificationState()) {
    on<FullNameEvent>(_fullNameEvent);
    on<StudentIdEvent>(_studentIdEvent);
    on<StartYearEvent>(_startYearEvent);
    on<AlumniVerificationResetEvent>(_registerResetEvent);
  }

  void _fullNameEvent(FullNameEvent event, Emitter<AlumniVerificationState> emit) {
    emit(state.copyWith(fullName: event.fullName));
  }

  void _studentIdEvent(StudentIdEvent event, Emitter<AlumniVerificationState> emit) {
    emit(state.copyWith(studentId: event.studentId));
  }

  void _startYearEvent(StartYearEvent event, Emitter<AlumniVerificationState> emit) {
    emit(state.copyWith(startYear: event.startYear));
  }

  void _registerResetEvent(AlumniVerificationResetEvent event, Emitter<AlumniVerificationState> emit) {
    emit(AlumniVerificationState()); // Reset the state to its initial state
  }
}
