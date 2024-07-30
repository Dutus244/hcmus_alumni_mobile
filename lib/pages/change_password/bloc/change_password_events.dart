abstract class ChangePasswordEvent {
  const ChangePasswordEvent();
}

class PasswordEvent extends ChangePasswordEvent {
  final String password;

  const PasswordEvent(this.password);
}

class RePasswordEvent extends ChangePasswordEvent {
  final String rePassword;

  const RePasswordEvent(this.rePassword);
}

class ChangePasswordResetEvent extends ChangePasswordEvent {}
