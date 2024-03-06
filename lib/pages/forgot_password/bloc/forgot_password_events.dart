abstract class ForgotPasswordEvent {
  const ForgotPasswordEvent();
}

class EmailEvent extends ForgotPasswordEvent {
  final String email;

  const EmailEvent(this.email);
}

class CodeEvent extends ForgotPasswordEvent {
  final String code;

  const CodeEvent(this.code);
}

class ForgotPasswordResetEvent extends ForgotPasswordEvent {}
