class ChangePasswordState {
  final String password;
  final String rePassword;
  final bool isLoading;
  final bool showPass;

  const ChangePasswordState({
    this.password = "",
    this.rePassword = "",
    this.isLoading = false,
    this.showPass = false,
  });

  ChangePasswordState copyWith({String? password, String? rePassword, bool? isLoading, bool? showPass}) {
    return ChangePasswordState(
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      isLoading: isLoading ?? this.isLoading,
      showPass: showPass ?? this.showPass,
    );
  }
}
