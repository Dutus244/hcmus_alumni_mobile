import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_post_group_events.dart';
import 'edit_post_group_states.dart';


class EditPostGroupBloc
    extends Bloc<EditPostGroupEvent, EditPostGroupState> {
  EditPostGroupBloc() : super(EditPostGroupState()) {
    on<TitleEvent>(_titleEvent);
    on<ContentEvent>(_contentEvent);
    on<TagsEvent>(_tagsEvent);
    on<PictureNetworksEvent>(_pictureNetworksEvent);
    on<PicturesEvent>(_picturesEvent);
    on<DeletePicturesEvent>(_deletePicturesEvent);
    on<PageEvent>(_pageEvent);
    on<IsLoadingEvent>(_isLoadingEvent);
    on<EditPostGroupResetEvent>(_editPostGroupResetEvent);
  }

  void _titleEvent(TitleEvent event, Emitter<EditPostGroupState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _contentEvent(ContentEvent event, Emitter<EditPostGroupState> emit) {
    emit(state.copyWith(content: event.content));
  }

  void _tagsEvent(TagsEvent event, Emitter<EditPostGroupState> emit) {
    emit(state.copyWith(tags: event.tags));
  }

  void _pictureNetworksEvent(
      PictureNetworksEvent event, Emitter<EditPostGroupState> emit) {
    emit(state.copyWith(pictureNetworks: event.pictureNetworks));
  }

  void _picturesEvent(PicturesEvent event, Emitter<EditPostGroupState> emit) {
    emit(state.copyWith(pictures: event.pictures));
  }

  void _deletePicturesEvent(
      DeletePicturesEvent event, Emitter<EditPostGroupState> emit) {
    emit(state.copyWith(deletePictures: event.deletePictures));
  }

  void _pageEvent(PageEvent event, Emitter<EditPostGroupState> emit) {
    emit(state.copyWith(page: event.page));
  }

  void _isLoadingEvent(IsLoadingEvent event, Emitter<EditPostGroupState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _editPostGroupResetEvent(
      EditPostGroupResetEvent event, Emitter<EditPostGroupState> emit) {
    emit(EditPostGroupState()); // Reset the state to its initial state
  }
}
