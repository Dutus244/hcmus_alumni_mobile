abstract class SignInEvent {
  const SignInEvent();
}

class EmailEvent extends SignInEvent {
  final String email;

  const EmailEvent(this.email);
}

class PasswordEvent extends SignInEvent {
  final String password;

  const PasswordEvent(this.password);
}

class RememberLoginEvent extends SignInEvent {
  final bool rememberLogin;

  const RememberLoginEvent(this.rememberLogin);
}

class SignInResetEvent extends SignInEvent {}
