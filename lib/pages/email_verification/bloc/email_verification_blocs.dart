import 'package:flutter_bloc/flutter_bloc.dart';

import 'email_verification_events.dart';
import 'email_verification_states.dart';

class EmailVerificationBloc
    extends Bloc<EmailVerificationEvent, EmailVerificationState> {
  EmailVerificationBloc() : super(EmailVerificationState()) {
    on<CodeEvent>(_codeEvent);
    on<EmailVerificationResetEvent>(_emailVerificationResetEvent);
  }

  void _codeEvent(CodeEvent event, Emitter<EmailVerificationState> emit) {
    emit(state.copyWith(code: event.code));
  }

  void _emailVerificationResetEvent(EmailVerificationResetEvent event, Emitter<EmailVerificationState> emit) {
    emit(EmailVerificationState());
  }
}
