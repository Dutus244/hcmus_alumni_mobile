class EmailVerificationState {
  final String code;
  final bool isLoading;

  const EmailVerificationState({
    this.code = "",
    this.isLoading = false,
  });

  EmailVerificationState copyWith({String? code, bool? isLoading}) {
    return EmailVerificationState(
        code: code ?? this.code, isLoading: isLoading ?? this.isLoading);
  }
}
