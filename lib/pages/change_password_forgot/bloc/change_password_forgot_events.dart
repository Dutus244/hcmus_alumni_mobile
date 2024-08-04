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

class CodeEvent extends ChangePasswordForgotEvent {
  final String code;

  const CodeEvent(this.code);
}

class IsLoadingEvent extends ChangePasswordForgotEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class ShowPassEvent extends ChangePasswordForgotEvent {
  final bool showPass;

  const ShowPassEvent(this.showPass);
}

class ChangePasswordForgotResetEvent extends ChangePasswordForgotEvent {}
