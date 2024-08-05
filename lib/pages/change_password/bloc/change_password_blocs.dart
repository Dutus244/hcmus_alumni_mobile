import 'package:flutter_bloc/flutter_bloc.dart';

import 'change_password_events.dart';
import 'change_password_states.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordState()) {
    on<PasswordEvent>(_passwordEvent);
    on<RePasswordEvent>(_rePasswordEvent);
    on<IsLoadingEvent>(_isLoadingEvent);
    on<ShowPassEvent>(_showPassEvent);
    on<ChangePasswordResetEvent>(_changePasswordResetEvent);
  }

  void _passwordEvent(
      PasswordEvent event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _rePasswordEvent(
      RePasswordEvent event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(rePassword: event.rePassword));
  }

  void _isLoadingEvent(
      IsLoadingEvent event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _showPassEvent(
      ShowPassEvent event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(showPass: event.showPass));
  }

  void _changePasswordResetEvent(ChangePasswordResetEvent event,
      Emitter<ChangePasswordState> emit) {
    emit(ChangePasswordState()); // Reset the state to its initial state
  }
}
