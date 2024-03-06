abstract class ChangePasswordForgotEvent {
  const ChangePasswordForgotEvent();
}

class PasswordEvent extends ChangePasswordForgotEvent {
  final String password;

  const PasswordEvent(this.password);
}

class RePasswordEvent extends ChangePasswordForgotEvent {
  final String rePassword;

  const RePasswordEvent(this.rePassword);
}

class ChangePasswordForgotResetEvent extends ChangePasswordForgotEvent {}
