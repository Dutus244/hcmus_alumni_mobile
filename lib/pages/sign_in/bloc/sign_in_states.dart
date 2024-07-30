class SignInState {
  final String email;
  final String password;
  final bool rememberLogin;

  const SignInState({
    this.email = "",
    this.password = "",
    this.rememberLogin = false,
  });

  SignInState copyWith({String? email, String? password, bool? rememberLogin}) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberLogin: rememberLogin ?? this.rememberLogin,
    );
  }
}
