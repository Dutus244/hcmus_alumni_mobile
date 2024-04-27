import 'package:hcmus_alumni_mobile/model/event.dart';

class EventDetailState {
  final int page;
  final List<Event> relatedEvent;

  EventDetailState({this.page = 0, this.relatedEvent = const []});

  EventDetailState copyWith({int? page, List<Event>? relatedEvent}) {
    return EventDetailState(
      page: page ?? this.page,
      relatedEvent: relatedEvent ?? this.relatedEvent,
    );
  }
}
