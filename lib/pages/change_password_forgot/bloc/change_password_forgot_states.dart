class ChangePasswordForgotState {
  final String password;
  final String rePassword;

  const ChangePasswordForgotState({
    this.password = "",
    this.rePassword = "",
  });

  ChangePasswordForgotState copyWith({String? password, String? rePassword}) {
    return ChangePasswordForgotState(
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
    );
  }
}
