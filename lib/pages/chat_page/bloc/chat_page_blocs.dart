import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_page_events.dart';
import 'chat_page_states.dart';

class ChatPageBloc extends Bloc<ChatPageEvent, ChatPageState> {
  ChatPageBloc() : super(ChatPageState()) {
    on<NameEvent>(_nameEvent);
    on<NameSearchEvent>(_nameSearchEvent);
    on<StatusEvent>(_statusEvent);
    on<InboxesEvent>(_inboxesEvent);
    on<IndexInboxEvent>(_indexInboxEvent);
    on<HasReachedMaxInboxEvent>(_hasReachedMaxInboxEvent);
  }

  void _nameEvent(NameEvent event, Emitter<ChatPageState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _nameSearchEvent(NameSearchEvent event, Emitter<ChatPageState> emit) {
    emit(state.copyWith(nameSearch: event.nameSearch));
  }

  void _statusEvent(StatusEvent event, Emitter<ChatPageState> emit) async {
    emit(state.copyWith(status: event.status));
  }

  void _inboxesEvent(InboxesEvent event, Emitter<ChatPageState> emit) async {
    emit(state.copyWith(inboxes: event.inboxes));
  }

  void _indexInboxEvent(IndexInboxEvent event, Emitter<ChatPageState> emit) {
    emit(state.copyWith(indexInbox: event.indexInbox));
  }

  void _hasReachedMaxInboxEvent(
      HasReachedMaxInboxEvent event, Emitter<ChatPageState> emit) {
    emit(state.copyWith(hasReachedMaxInbox: event.hasReachedMaxInbox));
  }
}
