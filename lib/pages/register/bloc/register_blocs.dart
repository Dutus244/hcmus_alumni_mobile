import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/register/bloc/register_events.dart';
import 'package:hcmus_alumni_mobile/pages/register/bloc/register_states.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<RePasswordEvent>(_rePasswordEvent);
    on<IsLoadingEvent>(_isLoadingEvent);
    on<ShowPassEvent>(_showPassEvent);
    on<RegisterResetEvent>(_registerResetEvent);
  }

  void _emailEvent(EmailEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _rePasswordEvent(RePasswordEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(rePassword: event.rePassword));
  }

  void _isLoadingEvent(IsLoadingEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _showPassEvent(ShowPassEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(showPass: event.showPass));
  }

  void _registerResetEvent(
      RegisterResetEvent event, Emitter<RegisterState> emit) {
    emit(RegisterState()); // Reset the state to its initial state
  }
}
