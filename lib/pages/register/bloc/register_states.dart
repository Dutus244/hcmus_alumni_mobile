class RegisterState {
  final String email;
  final String password;
  final String rePassword;

  const RegisterState({
    this.email = "",
    this.password = "",
    this.rePassword = "",
  });

  RegisterState copyWith(
      {String? email, String? password, String? rePassword}) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
    );
  }
}
