class ChangePasswordForgotState {
  final String password;
  final String rePassword;
  final String code;
  final bool isLoading;
  final bool showPass;

  const ChangePasswordForgotState({
    this.password = "",
    this.rePassword = "",
    this.code = "",
    this.isLoading = false,
    this.showPass = false,
  });

  ChangePasswordForgotState copyWith({String? password, String? rePassword, String? code, bool? isLoading, bool? showPass}) {
    return ChangePasswordForgotState(
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      code: code ?? this.code,
      isLoading: isLoading ?? this.isLoading,
      showPass: showPass ?? this.showPass,
    );
  }
}
