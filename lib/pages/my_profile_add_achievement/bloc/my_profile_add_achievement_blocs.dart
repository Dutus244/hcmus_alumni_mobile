import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_profile_add_achievement_events.dart';
import 'my_profile_add_achievement_states.dart';

class MyProfileAddAchievementBloc
    extends Bloc<MyProfileAddAchievementEvent, MyProfileAddAchievementState> {
  MyProfileAddAchievementBloc() : super(MyProfileAddAchievementState()) {
    on<NameEvent>(_nameEvent);
    on<TypeEvent>(_typeEvent);
    on<TimeEvent>(_timeEvent);
    on<IsLoadingEvent>(_isLoadingEvent);
    on<MyProfileAddAchievementResetEvent>(_myProfileAddAchievementResetEvent);
  }

  void _nameEvent(
      NameEvent event, Emitter<MyProfileAddAchievementState> emit) async {
    emit(state.copyWith(name: event.name));
  }

  void _typeEvent(
      TypeEvent event, Emitter<MyProfileAddAchievementState> emit) async {
    emit(state.copyWith(type: event.type));
  }

  void _timeEvent(
      TimeEvent event, Emitter<MyProfileAddAchievementState> emit) async {
    emit(state.copyWith(time: event.time));
  }

  void _isLoadingEvent(
      IsLoadingEvent event, Emitter<MyProfileAddAchievementState> emit) async {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _myProfileAddAchievementResetEvent(
      MyProfileAddAchievementResetEvent event, Emitter<MyProfileAddAchievementState> emit) async {
    emit(MyProfileAddAchievementState());
  }
}
