class EventDetailState {
  final int page;

  EventDetailState({this.page = 0});

  EventDetailState copyWith({int? page}) {
    return EventDetailState(
      page: page ?? this.page,
    );
  }
}
