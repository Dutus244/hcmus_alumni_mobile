abstract class EmailVerificationEvent {
  const EmailVerificationEvent();
}

class CodeEvent extends EmailVerificationEvent {
  final String code;

  const CodeEvent(this.code);
}

class IsLoadingEvent extends EmailVerificationEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class EmailVerificationResetEvent extends EmailVerificationEvent {}
