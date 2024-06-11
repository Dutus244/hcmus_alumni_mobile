import '../../../model/event.dart';

enum Status { loading, success }

class OtherProfilePageState {
  final Status statusEvent;
  final List<Event> events;
  final int indexEvent;
  final bool hasReachedMaxEvent;

  OtherProfilePageState({
    this.statusEvent = Status.loading,
    this.events = const [],
    this.indexEvent = 0,
    this.hasReachedMaxEvent = false,
  });

  OtherProfilePageState copyWith({
    Status? statusEvent,
    List<Event>? events,
    int? indexEvent,
    bool? hasReachedMaxEvent,
  }) {
    return OtherProfilePageState(
        statusEvent: statusEvent ?? this.statusEvent,
        events: events ?? this.events,
        indexEvent: indexEvent ?? this.indexEvent,
        hasReachedMaxEvent: hasReachedMaxEvent ?? this.hasReachedMaxEvent);
  }
}
