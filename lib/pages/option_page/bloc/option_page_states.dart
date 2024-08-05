class OptionPageState {
  final String locale;
  final bool isLoading;

  OptionPageState({this.locale = '', this.isLoading = false});

  OptionPageState copyWith({
    String? locale,
    bool? isLoading,
  }) {
    return OptionPageState(
        locale: locale ?? this.locale, isLoading: isLoading ?? this.isLoading);
  }
}
