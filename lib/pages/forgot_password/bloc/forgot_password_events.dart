abstract class ForgotPasswordEvent {
  const ForgotPasswordEvent();
}

class EmailEvent extends ForgotPasswordEvent {
  final String email;

  const EmailEvent(this.email);
}

class IsLoadingEvent extends ForgotPasswordEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class ForgotPasswordResetEvent extends ForgotPasswordEvent {}
