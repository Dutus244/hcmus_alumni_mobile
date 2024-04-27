import 'package:hcmus_alumni_mobile/model/event.dart';

class EventDetailEvent {
  const EventDetailEvent();
}

class PageEvent extends EventDetailEvent {
  final int page;

  const PageEvent(this.page);
}

class RelatedEventEvent extends EventDetailEvent {
  final List<Event> relatedEvent;

  const RelatedEventEvent(this.relatedEvent);
}
