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

class IsLoadingEvent extends ChangePasswordEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class ShowPassEvent extends ChangePasswordEvent {
  final bool showPass;

  const ShowPassEvent(this.showPass);
}

class ChangePasswordResetEvent extends ChangePasswordEvent {}
