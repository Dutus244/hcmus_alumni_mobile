import 'package:flutter_bloc/flutter_bloc.dart';

import 'alumni_information_events.dart';
import 'alumni_information_states.dart';


class AlumniInformationBloc extends Bloc<AlumniInformationEvent, AlumniInformationState> {
  AlumniInformationBloc() : super(AlumniInformationState()) {
    on<AvatarEvent>(_avatarEvent);
    on<FullNameEvent>(_fullNameEvent);
    on<AlumniInformationResetEvent>(_alumniInformationResetEvent);
  }

  void _avatarEvent(AvatarEvent event, Emitter<AlumniInformationState> emit) {
    print(event.avatar);
    emit(state.copyWith(avatar: event.avatar));
  }

  void _fullNameEvent(FullNameEvent event, Emitter<AlumniInformationState> emit) {
    emit(state.copyWith(fullName: event.fullName));
  }

  void _alumniInformationResetEvent(AlumniInformationResetEvent event, Emitter<AlumniInformationState> emit) {
    emit(AlumniInformationState()); // Reset the state to its initial state
  }
}
