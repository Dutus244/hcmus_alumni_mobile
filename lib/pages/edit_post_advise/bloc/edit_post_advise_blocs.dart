import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/edit_post_advise/bloc/edit_post_advise_events.dart';
import 'package:hcmus_alumni_mobile/pages/edit_post_advise/bloc/edit_post_advise_states.dart';

class EditPostAdviseBloc
    extends Bloc<EditPostAdviseEvent, EditPostAdviseState> {
  EditPostAdviseBloc() : super(EditPostAdviseState()) {
    on<TitleEvent>(_titleEvent);
    on<ContentEvent>(_contentEvent);
    on<TagsEvent>(_tagsEvent);
    on<ItemTagsEvent>(_itemTagsEvent);
    on<PictureNetworksEvent>(_pictureNetworksEvent);
    on<PicturesEvent>(_picturesEvent);
    on<DeletePicturesEvent>(_deletePicturesEvent);
    on<PageEvent>(_pageEvent);
    on<EditPostAdviseResetEvent>(_editPostAdviseResetEvent);
  }

  void _titleEvent(TitleEvent event, Emitter<EditPostAdviseState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _contentEvent(ContentEvent event, Emitter<EditPostAdviseState> emit) {
    emit(state.copyWith(content: event.content));
  }

  void _tagsEvent(TagsEvent event, Emitter<EditPostAdviseState> emit) {
    emit(state.copyWith(tags: event.tags));
  }

  void _itemTagsEvent(ItemTagsEvent event, Emitter<EditPostAdviseState> emit) {
    emit(state.copyWith(itemTags: event.itemTags));
  }

  void _pictureNetworksEvent(
      PictureNetworksEvent event, Emitter<EditPostAdviseState> emit) {
    emit(state.copyWith(pictureNetworks: event.pictureNetworks));
  }

  void _picturesEvent(PicturesEvent event, Emitter<EditPostAdviseState> emit) {
    emit(state.copyWith(pictures: event.pictures));
  }

  void _deletePicturesEvent(
      DeletePicturesEvent event, Emitter<EditPostAdviseState> emit) {
    emit(state.copyWith(deletePictures: event.deletePictures));
  }

  void _pageEvent(PageEvent event, Emitter<EditPostAdviseState> emit) {
    emit(state.copyWith(page: event.page));
  }

  void _editPostAdviseResetEvent(
      EditPostAdviseResetEvent event, Emitter<EditPostAdviseState> emit) {
    emit(EditPostAdviseState()); // Reset the state to its initial state
  }
}
