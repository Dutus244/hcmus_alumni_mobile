import 'package:flutter_bloc/flutter_bloc.dart';

import 'hof_detail_events.dart';
import 'hof_detail_states.dart';

class HofDetailBloc extends Bloc<HofDetailEvent, HofDetailState> {
  HofDetailBloc() : super(HofDetailState()) {
    on<HofEvent>(_hofEvent);
  }

  void _hofEvent(HofEvent event, Emitter<HofDetailState> emit) {
    emit(state.copyWith(hallOfFame: event.hallOfFame));
  }
}
