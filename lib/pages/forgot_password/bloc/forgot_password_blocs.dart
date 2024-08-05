import 'package:flutter_bloc/flutter_bloc.dart';

import 'forgot_password_events.dart';
import 'forgot_password_states.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordState()) {
    on<EmailEvent>(_emailEvent);
    on<IsLoadingEvent>(_isLoadingEvent);
    on<ForgotPasswordResetEvent>(_forgotPasswordResetEvent);
  }

  void _emailEvent(EmailEvent event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _isLoadingEvent(
      IsLoadingEvent event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _forgotPasswordResetEvent(
      ForgotPasswordResetEvent event, Emitter<ForgotPasswordState> emit) {
    emit(ForgotPasswordState()); // Reset the state to its initial state
  }
}
