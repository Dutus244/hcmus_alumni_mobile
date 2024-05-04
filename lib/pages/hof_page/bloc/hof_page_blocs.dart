import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/hof_page/hof_page_controller.dart';

import 'hof_page_events.dart';
import 'hof_page_states.dart';

class HofPageBloc extends Bloc<HofPageEvent, HofPageState> {
  HofPageBloc() : super(HofPageState()) {
    on<NameEvent>(_nameEvent);
    on<FacultyEvent>(_facultyEvent);
    on<BeginningYearEvent>(_beginningYearEvent);
    on<NameSearchEvent>(_nameSearchEvent);
    on<FacultySearchEvent>(_facultySearchEvent);
    on<BeginningYearSearchEvent>(_beginningYearSearchEvent);
    on<ClearFilterEvent>(_clearFilterEvent);
    on<HofPageResetEvent>(_hofPageResetEvent);
    on<StatusHofEvent>(_statusHofEvent);
    on<HallOfFameEvent>(_hallOfFameEvent);
    on<IndexHofEvent>(_indexHofEvent);
    on<HasReachedMaxHofEvent>(_hasReachedMaxHofEvent);
    on<ClearResultEvent>(_clearResultEvent);
  }

  void _nameEvent(NameEvent event, Emitter<HofPageState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _facultyEvent(FacultyEvent event, Emitter<HofPageState> emit) {
    emit(state.copyWith(faculty: event.faculty));
  }

  void _beginningYearEvent(
      BeginningYearEvent event, Emitter<HofPageState> emit) {
    emit(state.copyWith(beginningYear: event.beginningYear));
  }

  void _nameSearchEvent(NameSearchEvent event, Emitter<HofPageState> emit) {
    emit(state.copyWith(nameSearch: event.nameSearch));
  }

  void _facultySearchEvent(
      FacultySearchEvent event, Emitter<HofPageState> emit) {
    emit(state.copyWith(facultySearch: event.facultySearch));
  }

  void _beginningYearSearchEvent(
      BeginningYearSearchEvent event, Emitter<HofPageState> emit) {
    emit(state.copyWith(beginningYearSearch: event.beginningYearSearch));
  }

  void _statusHofEvent(StatusHofEvent event, Emitter<HofPageState> emit) async {
    emit(state.copyWith(statusHof: event.statusHof));
  }

  void _hallOfFameEvent(
      HallOfFameEvent event, Emitter<HofPageState> emit) async {
    emit(state.copyWith(hallOfFame: event.hallOfFame));
  }

  void _indexHofEvent(IndexHofEvent event, Emitter<HofPageState> emit) {
    emit(state.copyWith(indexHof: event.indexHof));
  }

  void _hasReachedMaxHofEvent(
      HasReachedMaxHofEvent event, Emitter<HofPageState> emit) {
    emit(state.copyWith(hasReachedMaxHof: event.hasReachedMaxHof));
  }

  void _clearFilterEvent(ClearFilterEvent event, Emitter<HofPageState> emit) {
    emit(state.copyWith(
        faculty: "",
        beginningYear: "",
        facultySearch: "",
        beginningYearSearch: ""));
  }

  void _hofPageResetEvent(HofPageResetEvent event, Emitter<HofPageState> emit) {
    emit(HofPageState()); // Reset the state to its initial state
  }

  void _clearResultEvent(ClearResultEvent event, Emitter<HofPageState> emit) {
    emit(state.copyWith(
        statusHof: Status.loading,
        hallOfFame: const [],
        indexHof: 0,
        hasReachedMaxHof: false));
  }
}
