import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/write_post_group/bloc/write_post_group_events.dart';
import 'package:hcmus_alumni_mobile/pages/write_post_group/bloc/write_post_group_states.dart';

class WritePostGroupBloc
    extends Bloc<WritePostGroupEvent, WritePostGroupState> {
  WritePostGroupBloc() : super(WritePostGroupState()) {
    on<TitleEvent>(_titleEvent);
    on<ContentEvent>(_contentEvent);
    on<TagsEvent>(_tagsEvent);
    on<PicturesEvent>(_picturesEvent);
    on<PageEvent>(_pageEvent);
    on<WritePostGroupResetEvent>(_writePostGroupResetEvent);
  }

  void _titleEvent(TitleEvent event, Emitter<WritePostGroupState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _contentEvent(ContentEvent event, Emitter<WritePostGroupState> emit) {
    emit(state.copyWith(content: event.content));
  }

  void _tagsEvent(TagsEvent event, Emitter<WritePostGroupState> emit) {
    emit(state.copyWith(tags: event.tags));
  }

  void _picturesEvent(PicturesEvent event, Emitter<WritePostGroupState> emit) {
    emit(state.copyWith(pictures: event.pictures));
  }

  void _pageEvent(PageEvent event, Emitter<WritePostGroupState> emit) {
    emit(state.copyWith(page: event.page));
  }

  void _writePostGroupResetEvent(
      WritePostGroupResetEvent event, Emitter<WritePostGroupState> emit) {
    emit(WritePostGroupState()); // Reset the state to its initial state
  }
}
