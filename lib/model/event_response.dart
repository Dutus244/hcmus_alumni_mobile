import 'event.dart';

class EventResponse {
  final List<Event> events;

  EventResponse(this.events);

  EventResponse.fromJson(Map<String, dynamic> json)
      : events =
            (json["events"] as List).map((i) => new Event.fromJson(i)).toList();
}
