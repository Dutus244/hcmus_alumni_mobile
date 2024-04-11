import 'package:flutter_bloc/flutter_bloc.dart';

import 'hof_page_events.dart';
import 'hof_page_states.dart';

class HofPageBloc extends Bloc<HofPageEvent, HofPageState> {
  HofPageBloc() : super(HofPageState()) {
    on<NameEvent>(_nameEvent);
    on<FacultyEvent>(_facultyEvent);
    on<GraduationYearEvent>(_graduationYearEvent);
    on<ClearFilterEvent>(_clearFilterEvent);
    on<HofPageResetEvent>(_hofPageResetEvent);
  }

  void _nameEvent(NameEvent event, Emitter<HofPageState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _facultyEvent(FacultyEvent event, Emitter<HofPageState> emit) {
    emit(state.copyWith(faculty: event.faculty));
  }

  void _graduationYearEvent(
      GraduationYearEvent event, Emitter<HofPageState> emit) {
    emit(state.copyWith(graduationYear: event.graduationYear));
  }

  void _clearFilterEvent(
     ClearFilterEvent event, Emitter<HofPageState> emit) {
    emit(state.copyWith(faculty: "", graduationYear: ""));
  }

  void _hofPageResetEvent(HofPageResetEvent event, Emitter<HofPageState> emit) {
    emit(HofPageState()); // Reset the state to its initial state
  }
}
