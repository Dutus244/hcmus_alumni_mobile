import 'package:flutter_bloc/flutter_bloc.dart';

import 'change_password_forgot_events.dart';
import 'change_password_forgot_states.dart';

class ChangePasswordForgotBloc
    extends Bloc<ChangePasswordForgotEvent, ChangePasswordForgotState> {
  ChangePasswordForgotBloc() : super(ChangePasswordForgotState()) {
    on<PasswordEvent>(_passwordEvent);
    on<RePasswordEvent>(_rePasswordEvent);
    on<ChangePasswordForgotResetEvent>(_changePasswordForgotResetEvent);
  }

  void _passwordEvent(
      PasswordEvent event, Emitter<ChangePasswordForgotState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _rePasswordEvent(
      RePasswordEvent event, Emitter<ChangePasswordForgotState> emit) {
    emit(state.copyWith(rePassword: event.rePassword));
  }

  void _changePasswordForgotResetEvent(ChangePasswordForgotResetEvent event,
      Emitter<ChangePasswordForgotState> emit) {
    emit(ChangePasswordForgotState()); // Reset the state to its initial state
  }
}
