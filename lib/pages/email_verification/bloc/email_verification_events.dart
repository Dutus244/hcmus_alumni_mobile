abstract class EmailVerificationEvent {
  const EmailVerificationEvent();
}

class CodeEvent extends EmailVerificationEvent {
  final String code;

  const CodeEvent(this.code);
}

class EmailVerificationResetEvent extends EmailVerificationEvent {}
