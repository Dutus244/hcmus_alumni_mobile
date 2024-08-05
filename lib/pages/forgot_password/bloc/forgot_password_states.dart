class ForgotPasswordState {
  final String email;
  final bool isLoading;

  const ForgotPasswordState({
    this.email = "",
    this.isLoading = false,
  });

  ForgotPasswordState copyWith({String? email, String? code, bool? isLoading}) {
    return ForgotPasswordState(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
