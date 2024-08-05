class OptionPageEvent {
  const OptionPageEvent();
}

class LocaleEvent extends OptionPageEvent {
  final String locale;

  const LocaleEvent(this.locale);
}

class IsLoadingEvent extends OptionPageEvent {
  final bool isLoading;

  const IsLoadingEvent(this.isLoading);
}