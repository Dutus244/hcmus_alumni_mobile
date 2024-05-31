import 'package:hcmus_alumni_mobile/model/comment.dart';
import 'package:hcmus_alumni_mobile/model/event.dart';

import '../../../model/participant.dart';
import 'event_detail_states.dart';

class EventDetailEvent {
  const EventDetailEvent();
}

class PageEvent extends EventDetailEvent {
  final int page;

  const PageEvent(this.page);
}

class EventEvent extends EventDetailEvent {
  final Event event;

  const EventEvent(this.event);
}

class RelatedEventsEvent extends EventDetailEvent {
  final List<Event> relatedEvents;

  const RelatedEventsEvent(this.relatedEvents);
}

class CommentsEvent extends EventDetailEvent {
  final List<Comment> comments;

  const CommentsEvent(this.comments);
}

class IndexCommentEvent extends EventDetailEvent {
  final int indexComment;

  const IndexCommentEvent(this.indexComment);
}

class HasReachedMaxCommentEvent extends EventDetailEvent {
  final bool hasReachedMaxComment;

  const HasReachedMaxCommentEvent(this.hasReachedMaxComment);
}

class IsParticipatedEvent extends EventDetailEvent {
  final bool isParticipated;

  const IsParticipatedEvent(this.isParticipated);
}

class StatusParticipantEvent extends EventDetailEvent {
  final Status statusParticipant;

  const StatusParticipantEvent(this.statusParticipant);
}

class ParticipantsEvent extends EventDetailEvent {
  final List<Participant> participants;

  const ParticipantsEvent(this.participants);
}

class IndexParticipantEvent extends EventDetailEvent {
  final int indexParticipant;

  const IndexParticipantEvent(this.indexParticipant);
}

class HasReachedMaxParticipantEvent extends EventDetailEvent {
  final bool hasReachedMaxParticipant;

  const HasReachedMaxParticipantEvent(this.hasReachedMaxParticipant);
}

