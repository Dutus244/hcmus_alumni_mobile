class NewsDetailState {
  final double fontSize;
  final String fontFamily;

  NewsDetailState({this.fontSize = 40, this.fontFamily = "Roboto"});

  NewsDetailState copyWith({double? fontSize, String? fontFamily}) {
    return NewsDetailState(
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }
}
