class NewsEventPageState {
  final int page;

  NewsEventPageState({this.page = 0});

  NewsEventPageState copyWith({int? page}) {
    return NewsEventPageState(
      page: page ?? this.page,
    );
  }
}
