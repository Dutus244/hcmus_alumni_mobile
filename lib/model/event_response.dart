import 'event.dart';

class EventResponse {
  final List<Event> event;

  EventResponse(this.event);

  EventResponse.fromJson(Map<String, dynamic> json)
      : event =
            (json["events"] as List).map((i) => new Event.fromJson(i)).toList();
}
