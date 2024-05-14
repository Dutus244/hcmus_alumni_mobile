import 'package:flutter_bloc/flutter_bloc.dart';

import 'advise_page_events.dart';
import 'advise_page_states.dart';

class AdvisePageBloc extends Bloc<AdvisePageEvent, AdvisePageState> {
  AdvisePageBloc() : super(AdvisePageState()) {
    on<StatusPostEvent>(_statusPostEvent);
    on<PostEvent>(_postEvent);
    on<IndexPostEvent>(_indexPostEvent);
    on<HasReachedMaxPostEvent>(_hasReachedMaxPostEvent);
  }

  void _statusPostEvent(
      StatusPostEvent event, Emitter<AdvisePageState> emit) async {
    emit(state.copyWith(statusPost: event.statusPost));
  }

  void _postEvent(PostEvent event, Emitter<AdvisePageState> emit) async {
    emit(state.copyWith(post: event.post));
  }

  void _indexPostEvent(IndexPostEvent event, Emitter<AdvisePageState> emit) {
    emit(state.copyWith(indexPost: event.indexPost));
  }

  void _hasReachedMaxPostEvent(
      HasReachedMaxPostEvent event, Emitter<AdvisePageState> emit) {
    emit(state.copyWith(hasReachedMaxPost: event.hasReachedMaxPost));
  }
}
