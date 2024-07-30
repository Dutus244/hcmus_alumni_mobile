import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/sign_in/bloc/sign_in_events.dart';
import 'package:hcmus_alumni_mobile/pages/sign_in/bloc/sign_in_states.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState()) {
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<RememberLoginEvent>(_rememberLoginEvent);
    on<SignInResetEvent>(_signInResetEvent);
  }

  void _emailEvent(EmailEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _rememberLoginEvent(
      RememberLoginEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(rememberLogin: event.rememberLogin));
  }

  void _signInResetEvent(SignInResetEvent event, Emitter<SignInState> emit) {
    emit(SignInState()); // Reset the state to its initial state
  }
}
