class EventDetailEvent {
  const EventDetailEvent();
}

class PageEvent extends EventDetailEvent {
  final int page;

  const PageEvent(this.page);
}
