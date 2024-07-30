class OptionPageState {
  final String locale;

  OptionPageState({this.locale = ''});

  OptionPageState copyWith({
    String? locale,
  }) {
    return OptionPageState(locale: locale ?? this.locale);
  }
}
