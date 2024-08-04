abstract class RegisterEvent {
  const RegisterEvent();
}

class EmailEvent extends RegisterEvent {
  final String email;

  const EmailEvent(this.email);
}

class PasswordEvent extends RegisterEvent {
  final String password;

  const PasswordEvent(this.password);
}

class RePasswordEvent extends RegisterEvent {
  final String rePassword;

  const RePasswordEvent(this.rePassword);
}

class IsLoadingEvent extends RegisterEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}

class ShowPassEvent extends RegisterEvent {
  final bool showPass;

  const ShowPassEvent(this.showPass);
}

class RegisterResetEvent extends RegisterEvent {}
