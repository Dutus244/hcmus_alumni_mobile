class SignInState {
  final String email;
  final String password;
  final bool rememberLogin;
  final bool isLoading;
  final bool showPass;

  const SignInState({
    this.email = "",
    this.password = "",
    this.rememberLogin = false,
    this.isLoading = false,
    this.showPass = false,
  });

  SignInState copyWith({String? email, String? password, bool? rememberLogin, bool? isLoading, bool? showPass}) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberLogin: rememberLogin ?? this.rememberLogin,
      isLoading: isLoading ?? this.isLoading,
      showPass: showPass ?? this.showPass,
    );
  }
}
