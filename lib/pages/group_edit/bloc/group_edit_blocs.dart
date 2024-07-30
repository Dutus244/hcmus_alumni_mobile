import 'package:flutter_bloc/flutter_bloc.dart';

import 'group_edit_events.dart';
import 'group_edit_states.dart';

class GroupEditBloc extends Bloc<GroupEditEvent, GroupEditState> {
  GroupEditBloc() : super(GroupEditState()) {
    on<NameEvent>(_nameEvent);
    on<DescriptionEvent>(_descriptionEvent);
    on<PrivacyEvent>(_privacyEvent);
    on<NetworkPictureEvent>(_networkPictureEvent);
    on<PicturesEvent>(_picturesEvent);
    on<TagsEvent>(_tagsEvent);
    on<GroupEditResetEvent>(_groupEditResetEvent);
  }

  void _nameEvent(NameEvent event, Emitter<GroupEditState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _descriptionEvent(DescriptionEvent event, Emitter<GroupEditState> emit) {
    emit(state.copyWith(description: event.description));
  }

  void _privacyEvent(PrivacyEvent event, Emitter<GroupEditState> emit) {
    emit(state.copyWith(privacy: event.privacy));
  }

  void _networkPictureEvent(
      NetworkPictureEvent event, Emitter<GroupEditState> emit) {
    emit(state.copyWith(networkPicture: event.networkPicture));
  }

  void _picturesEvent(PicturesEvent event, Emitter<GroupEditState> emit) {
    emit(state.copyWith(pictures: event.pictures));
  }

  void _tagsEvent(TagsEvent event, Emitter<GroupEditState> emit) {
    emit(state.copyWith(tags: event.tags));
  }

  void _groupEditResetEvent(
      GroupEditResetEvent event, Emitter<GroupEditState> emit) {
    emit(GroupEditState());
  }
}
