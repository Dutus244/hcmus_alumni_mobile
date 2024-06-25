import 'package:flutter_bloc/flutter_bloc.dart';

import 'option_page_events.dart';
import 'option_page_states.dart';

class OptionPageBloc extends Bloc<OptionPageEvent, OptionPageState> {
  OptionPageBloc() : super(OptionPageState()) {
    on<LocaleEvent>(_localeEvent);
  }

  void _localeEvent(LocaleEvent event, Emitter<OptionPageState> emit) {
    emit(state.copyWith(locale: event.locale));
  }
}