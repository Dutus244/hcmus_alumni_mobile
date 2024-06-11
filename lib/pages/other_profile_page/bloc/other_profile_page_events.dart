import 'package:hcmus_alumni_mobile/model/event.dart';

import '../../../model/post.dart';
import 'other_profile_page_states.dart';

class OtherProfilePageEvent {
  const OtherProfilePageEvent();
}

class StatusEventEvent extends OtherProfilePageEvent {
  final Status statusEvent;

  const StatusEventEvent(this.statusEvent);
}

class EventsEvent extends OtherProfilePageEvent {
  final List<Event> events;

  const EventsEvent(this.events);
}

class IndexEventEvent extends OtherProfilePageEvent {
  final int indexEvent;

  const IndexEventEvent(this.indexEvent);
}

class HasReachedMaxEventEvent extends OtherProfilePageEvent {
  final bool hasReachedMaxEvent;

  const HasReachedMaxEventEvent(this.hasReachedMaxEvent);
}