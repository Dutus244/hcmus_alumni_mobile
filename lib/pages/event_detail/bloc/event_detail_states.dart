import 'package:hcmus_alumni_mobile/model/comment.dart';
import 'package:hcmus_alumni_mobile/model/event.dart';

import '../../../model/participant.dart';

enum Status { loading, success }

class EventDetailState {
  final int page;
  final Event? event;
  final List<Event> relatedEvents;

  final List<Comment> comments;
  final int indexComment;
  final bool hasReachedMaxComment;

  final Status statusParticipant;
  final List<Participant> participants;
  final int indexParticipant;
  final bool hasReachedMaxParticipant;
  final bool isLoading;

  EventDetailState(
      {this.page = 0,
      this.event = null,
      this.relatedEvents = const [],
      this.comments = const [],
      this.indexComment = 0,
      this.hasReachedMaxComment = false,
      this.statusParticipant = Status.loading,
      this.participants = const [],
      this.indexParticipant = 0,
      this.hasReachedMaxParticipant = false,
      this.isLoading = false});

  EventDetailState copyWith(
      {int? page,
      Event? event,
      List<Event>? relatedEvents,
      List<Comment>? comments,
      int? indexComment,
      bool? hasReachedMaxComment,
      Status? statusParticipant,
      List<Participant>? participants,
      int? indexParticipant,
      bool? hasReachedMaxParticipant,
      bool? isLoading}) {
    return EventDetailState(
      page: page ?? this.page,
      event: event ?? this.event,
      relatedEvents: relatedEvents ?? this.relatedEvents,
      comments: comments ?? this.comments,
      indexComment: indexComment ?? this.indexComment,
      hasReachedMaxComment: hasReachedMaxComment ?? this.hasReachedMaxComment,
      statusParticipant: statusParticipant ?? this.statusParticipant,
      participants: participants ?? this.participants,
      indexParticipant: indexParticipant ?? this.indexParticipant,
      hasReachedMaxParticipant:
          hasReachedMaxParticipant ?? this.hasReachedMaxParticipant,
      isLoading: isLoading ?? this.isLoading
    );
  }
}
