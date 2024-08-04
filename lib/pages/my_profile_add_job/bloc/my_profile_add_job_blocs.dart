import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_profile_add_job_events.dart';
import 'my_profile_add_job_states.dart';

class MyProfileAddJobBloc
    extends Bloc<MyProfileAddJobEvent, MyProfileAddJobState> {
  MyProfileAddJobBloc() : super(MyProfileAddJobState()) {
    on<CompanyNameEvent>(_companyNameEvent);
    on<PositionEvent>(_positionEvent);
    on<StartTimeEvent>(_startTimeEvent);
    on<IsWorkingEvent>(_isWorkingEvent);
    on<EndTimeEvent>(_endTimeEvent);
    on<IsLoadingEvent>(_isLoadingEvent);
    on<MyProfileAddJobResetEvent>(_myProfileAddJobResetEvent);
  }

  void _companyNameEvent(
      CompanyNameEvent event, Emitter<MyProfileAddJobState> emit) async {
    emit(state.copyWith(companyName: event.comapyName));
  }

  void _positionEvent(
      PositionEvent event, Emitter<MyProfileAddJobState> emit) async {
    emit(state.copyWith(position: event.position));
  }

  void _startTimeEvent(
      StartTimeEvent event, Emitter<MyProfileAddJobState> emit) async {
    emit(state.copyWith(startTime: event.startTime));
  }

  void _isWorkingEvent(
      IsWorkingEvent event, Emitter<MyProfileAddJobState> emit) async {
    emit(state.copyWith(isWorking: event.isWorking));
  }

  void _endTimeEvent(
      EndTimeEvent event, Emitter<MyProfileAddJobState> emit) async {
    emit(state.copyWith(endTime: event.endTime));
  }

  void _isLoadingEvent(
      IsLoadingEvent event, Emitter<MyProfileAddJobState> emit) async {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _myProfileAddJobResetEvent(
      MyProfileAddJobResetEvent event, Emitter<MyProfileAddJobState> emit) async {
    emit(MyProfileAddJobState());
  }
}
