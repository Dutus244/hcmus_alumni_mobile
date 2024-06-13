class ChangePasswordState {
  final String password;
  final String rePassword;

  const ChangePasswordState({
    this.password = "",
    this.rePassword = "",
  });

  ChangePasswordState copyWith({String? password, String? rePassword}) {
    return ChangePasswordState(
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
    );
  }
}
