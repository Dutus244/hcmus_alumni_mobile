class ForgotPasswordState {
  final String email;
  final String code;

  const ForgotPasswordState({
    this.email = "",
    this.code = "",
  });

  ForgotPasswordState copyWith({String? email, String? code}) {
    return ForgotPasswordState(
      email: email ?? this.email,
      code: code ?? this.code,
    );
  }
}
