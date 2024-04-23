class NewsDetailEvent {
  const NewsDetailEvent();
}

class FontSizeEvent extends NewsDetailEvent {
  final double fontSize;

  const FontSizeEvent(this.fontSize);
}

class FontSizeResetEvent extends NewsDetailEvent {}

class FontFamilyEvent extends NewsDetailEvent {
  final String fontFamily;

  const FontFamilyEvent(this.fontFamily);
}
