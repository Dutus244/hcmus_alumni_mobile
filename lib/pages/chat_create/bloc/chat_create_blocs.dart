import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_create_events.dart';
import 'chat_create_states.dart';

class ChatCreateBloc extends Bloc<ChatCreateEvent, ChatCreateState> {
  ChatCreateBloc() : super(ChatCreateState()) {
    on<NameEvent>(_nameEvent);
    on<NameSearchEvent>(_nameSearchEvent);
    on<StatusEvent>(_statusEvent);
    on<UsersEvent>(_usersEvent);
    on<IndexUserEvent>(_indexUserEvent);
    on<HasReachedMaxUserEvent>(_hasReachedMaxUserEvent);
  }

  void _nameEvent(NameEvent event, Emitter<ChatCreateState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _nameSearchEvent(NameSearchEvent event, Emitter<ChatCreateState> emit) {
    emit(state.copyWith(nameSearch: event.nameSearch));
  }

  void _statusEvent(StatusEvent event, Emitter<ChatCreateState> emit) async {
    emit(state.copyWith(status: event.status));
  }

  void _usersEvent(UsersEvent event, Emitter<ChatCreateState> emit) async {
    emit(state.copyWith(users: event.users));
  }

  void _indexUserEvent(IndexUserEvent event, Emitter<ChatCreateState> emit) {
    emit(state.copyWith(indexUser: event.indexUser));
  }

  void _hasReachedMaxUserEvent(
      HasReachedMaxUserEvent event, Emitter<ChatCreateState> emit) {
    emit(state.copyWith(hasReachedMaxUser: event.hasReachedMaxUser));
  }
}
