import 'package:flutter_bloc/flutter_bloc.dart';

import 'group_create_events.dart';
import 'group_create_states.dart';

class GroupCreateBloc
    extends Bloc<GroupCreateEvent, GroupCreateState> {
  GroupCreateBloc() : super(GroupCreateState()) {
    on<NameEvent>(_nameEvent);
    on<DescriptionEvent>(_descriptionEvent);
    on<PrivacyEvent>(_privacyEvent);
    on<PicturesEvent>(_picturesEvent);
    on<TagsEvent>(_tagsEvent);
    on<GroupCreateResetEvent>(_groupCreateResetEvent);
  }

  void _nameEvent(NameEvent event, Emitter<GroupCreateState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _descriptionEvent(DescriptionEvent event, Emitter<GroupCreateState> emit) {
    emit(state.copyWith(description: event.description));
  }

  void _privacyEvent(PrivacyEvent event, Emitter<GroupCreateState> emit) {
    emit(state.copyWith(privacy: event.privacy));
  }

  void _picturesEvent(PicturesEvent event, Emitter<GroupCreateState> emit) {
    emit(state.copyWith(pictures: event.pictures));
  }

  void _tagsEvent(TagsEvent event, Emitter<GroupCreateState> emit) {
    emit(state.copyWith(tags: event.tags));
  }

  void _groupCreateResetEvent(GroupCreateResetEvent event, Emitter<GroupCreateState> emit) {
    emit(GroupCreateState());
  }
}