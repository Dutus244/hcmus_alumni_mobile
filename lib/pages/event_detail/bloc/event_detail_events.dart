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

class RelatedEventEvent extends EventDetailEvent {
  final List<Event> relatedEvent;

  const RelatedEventEvent(this.relatedEvent);
}

class CommentEvent extends EventDetailEvent {
  final List<Comment> comment;

  const CommentEvent(this.comment);
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

class ParticipantEvent extends EventDetailEvent {
  final List<Participant> participant;

  const ParticipantEvent(this.participant);
}

class IndexParticipantEvent extends EventDetailEvent {
  final int indexParticipant;

  const IndexParticipantEvent(this.indexParticipant);
}

class HasReachedMaxParticipantEvent extends EventDetailEvent {
  final bool hasReachedMaxParticipant;

  const HasReachedMaxParticipantEvent(this.hasReachedMaxParticipant);
}

