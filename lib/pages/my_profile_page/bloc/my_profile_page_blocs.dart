import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_profile_page_events.dart';
import 'my_profile_page_states.dart';

class MyProfilePageBloc extends Bloc<MyProfilePageEvent, MyProfilePageState> {
  MyProfilePageBloc() : super(MyProfilePageState()) {
    on<PageEvent>(_pageEvent);
    on<StatusPostEvent>(_statusPostEvent);
    on<PostsEvent>(_postsEvent);
    on<IndexPostEvent>(_indexPostEvent);
    on<HasReachedMaxPostEvent>(_hasReachedMaxPostEvent);
    on<StatusEventEvent>(_statusEventEvent);
    on<EventsEvent>(_eventsEvent);
    on<IndexEventEvent>(_indexEventEvent);
    on<HasReachedMaxEventEvent>(_hasReachedMaxEventEvent);
  }

  void _pageEvent(PageEvent event, Emitter<MyProfilePageState> emit) {
    emit(state.copyWith(page: event.page));
  }

  void _statusPostEvent(
      StatusPostEvent event, Emitter<MyProfilePageState> emit) async {
    emit(state.copyWith(statusPost: event.statusPost));
  }

  void _postsEvent(PostsEvent event, Emitter<MyProfilePageState> emit) async {
    emit(state.copyWith(posts: event.posts));
  }

  void _indexPostEvent(IndexPostEvent event, Emitter<MyProfilePageState> emit) {
    emit(state.copyWith(indexPost: event.indexPost));
  }

  void _hasReachedMaxPostEvent(
      HasReachedMaxPostEvent event, Emitter<MyProfilePageState> emit) {
    emit(state.copyWith(hasReachedMaxPost: event.hasReachedMaxPost));
  }

  void _statusEventEvent(
      StatusEventEvent event, Emitter<MyProfilePageState> emit) async {
    emit(state.copyWith(statusEvent: event.statusEvent));
  }

  void _eventsEvent(EventsEvent event, Emitter<MyProfilePageState> emit) async {
    emit(state.copyWith(events: event.events));
  }

  void _indexEventEvent(
      IndexEventEvent event, Emitter<MyProfilePageState> emit) {
    emit(state.copyWith(indexEvent: event.indexEvent));
  }

  void _hasReachedMaxEventEvent(
      HasReachedMaxEventEvent event, Emitter<MyProfilePageState> emit) {
    emit(state.copyWith(hasReachedMaxEvent: event.hasReachedMaxEvent));
  }
}