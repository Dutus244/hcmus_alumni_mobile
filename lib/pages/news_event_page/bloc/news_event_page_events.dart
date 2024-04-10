class NewsEventPageEvent {
  const NewsEventPageEvent();
}

class NewsEventPageIndexEvent extends NewsEventPageEvent {
  final int page;

  const NewsEventPageIndexEvent(this.page);
}