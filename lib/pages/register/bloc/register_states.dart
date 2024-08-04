class RegisterState {
  final String email;
  final String password;
  final String rePassword;
  final bool isLoading;
  final bool showPass;

  const RegisterState({
    this.email = "",
    this.password = "",
    this.rePassword = "",
    this.isLoading = false,
    this.showPass = false,
  });

  RegisterState copyWith(
      {String? email, String? password, String? rePassword, bool? isLoading, bool? showPass}) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      isLoading: isLoading ?? this.isLoading,
      showPass: showPass ?? this.showPass,
    );
  }
}
