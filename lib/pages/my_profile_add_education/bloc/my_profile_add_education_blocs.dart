import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_profile_add_education_events.dart';
import 'my_profile_add_education_states.dart';

class MyProfileAddEducationBloc
    extends Bloc<MyProfileAddEducationEvent, MyProfileAddEducationState> {
  MyProfileAddEducationBloc() : super(MyProfileAddEducationState()) {
    on<SchoolNameEvent>(_schoolNameEvent);
    on<DegreeEvent>(_degreeEvent);
    on<StartTimeEvent>(_startTimeEvent);
    on<IsStudyingEvent>(_isStudyingEvent);
    on<EndTimeEvent>(_endTimeEvent);
    on<IsLoadingEvent>(_isLoadingEvent);
    on<MyProfileAddEducationResetEvent>(_myProfileAddEducationResetEvent);
  }

  void _schoolNameEvent(
      SchoolNameEvent event, Emitter<MyProfileAddEducationState> emit) async {
    emit(state.copyWith(schoolName: event.schoolName));
  }

  void _degreeEvent(
      DegreeEvent event, Emitter<MyProfileAddEducationState> emit) async {
    emit(state.copyWith(degree: event.degree));
  }

  void _startTimeEvent(
      StartTimeEvent event, Emitter<MyProfileAddEducationState> emit) async {
    emit(state.copyWith(startTime: event.startTime));
  }

  void _isStudyingEvent(
      IsStudyingEvent event, Emitter<MyProfileAddEducationState> emit) async {
    emit(state.copyWith(isStudying: event.isStudying));
  }

  void _endTimeEvent(
      EndTimeEvent event, Emitter<MyProfileAddEducationState> emit) async {
    emit(state.copyWith(endTime: event.endTime));
  }

  void _isLoadingEvent(
      IsLoadingEvent event, Emitter<MyProfileAddEducationState> emit) async {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _myProfileAddEducationResetEvent(
      MyProfileAddEducationResetEvent event, Emitter<MyProfileAddEducationState> emit) async {
    emit(MyProfileAddEducationState());
  }
}
