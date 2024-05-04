import 'package:hcmus_alumni_mobile/model/comment.dart';
import 'package:hcmus_alumni_mobile/model/event.dart';

import '../../../model/participant.dart';

enum Status { loading, success }

class EventDetailState {
  final int page;
  final Event? event;
  final List<Event> relatedEvent;

  final List<Comment> comment;
  final int indexComment;
  final bool hasReachedMaxComment;

  final bool isParticipated;

  final Status statusParticipant;
  final List<Participant> participant;
  final int indexParticipant;
  final bool hasReachedMaxParticipant;

  EventDetailState(
      {this.page = 0,
      this.event = null,
      this.relatedEvent = const [],
      this.comment = const [],
      this.indexComment = 0,
      this.hasReachedMaxComment = false,
      this.isParticipated = false,
      this.statusParticipant = Status.loading,
      this.participant = const [],
      this.indexParticipant = 0,
      this.hasReachedMaxParticipant = false});

  EventDetailState copyWith(
      {int? page,
      Event? event,
      List<Event>? relatedEvent,
      List<Comment>? comment,
      int? indexComment,
      bool? hasReachedMaxComment,
      bool? isParticipated,
      Status? statusParticipant,
      List<Participant>? participant,
      int? indexParticipant,
      bool? hasReachedMaxParticipant}) {
    return EventDetailState(
      page: page ?? this.page,
      event: event ?? this.event,
      relatedEvent: relatedEvent ?? this.relatedEvent,
      comment: comment ?? this.comment,
      indexComment: indexComment ?? this.indexComment,
      hasReachedMaxComment: hasReachedMaxComment ?? this.hasReachedMaxComment,
      isParticipated: isParticipated ?? this.isParticipated,
      statusParticipant: statusParticipant ?? this.statusParticipant,
      participant: participant ?? this.participant,
      indexParticipant: indexParticipant ?? this.indexParticipant,
      hasReachedMaxParticipant:
          hasReachedMaxParticipant ?? this.hasReachedMaxParticipant,
    );
  }
}
