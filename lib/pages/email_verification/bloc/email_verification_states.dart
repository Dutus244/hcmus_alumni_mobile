class EmailVerificationState {
  final String code;

  const EmailVerificationState({
    this.code = "",
  });

  EmailVerificationState copyWith({String? code}) {
    return EmailVerificationState(
      code: code ?? this.code,
    );
  }
}
