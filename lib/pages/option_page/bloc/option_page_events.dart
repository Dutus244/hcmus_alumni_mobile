class OptionPageEvent {
  const OptionPageEvent();
}

class LocaleEvent extends OptionPageEvent {
  final String locale;

  const LocaleEvent(this.locale);
}
