import 'package:flutter_bloc/flutter_bloc.dart';

import 'event_detail_events.dart';
import 'event_detail_states.dart';

class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  EventDetailBloc() : super(EventDetailState()) {
    on<PageEvent>(_pageEvent);
    on<EventEvent>(_eventEvent);
    on<RelatedEventsEvent>(_relatedEventsEvent);
    on<CommentsEvent>(_commentsEvent);
    on<IndexCommentEvent>(_indexCommentEvent);
    on<HasReachedMaxCommentEvent>(_hasReachedMaxCommentEvent);
    on<IsParticipatedEvent>(_isParticipatedEvent);
    on<StatusParticipantEvent>(_statusParticipantEvent);
    on<ParticipantsEvent>(_participantsEvent);
    on<IndexParticipantEvent>(_indexParticipantEvent);
    on<HasReachedMaxParticipantEvent>(_hasReachedMaxParticipantEvent);
  }

  void _pageEvent(PageEvent event, Emitter<EventDetailState> emit) {
    emit(state.copyWith(page: event.page));
  }

  void _eventEvent(EventEvent event, Emitter<EventDetailState> emit) {
    emit(state.copyWith(event: event.event));
  }

  void _relatedEventsEvent(
      RelatedEventsEvent event, Emitter<EventDetailState> emit) {
    emit(state.copyWith(relatedEvents: event.relatedEvents));
  }

  void _commentsEvent(CommentsEvent event, Emitter<EventDetailState> emit) async {
    emit(state.copyWith(comments: event.comments));
  }

  void _indexCommentEvent(
      IndexCommentEvent event, Emitter<EventDetailState> emit) {
    emit(state.copyWith(indexComment: event.indexComment));
  }

  void _hasReachedMaxCommentEvent(
      HasReachedMaxCommentEvent event, Emitter<EventDetailState> emit) {
    emit(state.copyWith(hasReachedMaxComment: event.hasReachedMaxComment));
  }

  void _isParticipatedEvent(
      IsParticipatedEvent event, Emitter<EventDetailState> emit) {
    emit(state.copyWith(isParticipated: event.isParticipated));
  }

  void _statusParticipantEvent(
      StatusParticipantEvent event, Emitter<EventDetailState> emit) async {
    emit(state.copyWith(statusParticipant: event.statusParticipant));
  }

  void _participantsEvent(
      ParticipantsEvent event, Emitter<EventDetailState> emit) async {
    emit(state.copyWith(participants: event.participants));
  }

  void _indexParticipantEvent(
      IndexParticipantEvent event, Emitter<EventDetailState> emit) {
    emit(state.copyWith(indexParticipant: event.indexParticipant));
  }

  void _hasReachedMaxParticipantEvent(
      HasReachedMaxParticipantEvent event, Emitter<EventDetailState> emit) {
    emit(state.copyWith(
        hasReachedMaxParticipant: event.hasReachedMaxParticipant));
  }
}
