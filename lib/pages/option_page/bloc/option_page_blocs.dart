import 'package:flutter_bloc/flutter_bloc.dart';

import 'option_page_events.dart';
import 'option_page_states.dart';

class OptionPageBloc extends Bloc<OptionPageEvent, OptionPageState> {
  OptionPageBloc() : super(OptionPageState()) {
    on<LocaleEvent>(_localeEvent);
    on<IsLoadingEvent>(_isLoadingEvent);
  }

  void _localeEvent(LocaleEvent event, Emitter<OptionPageState> emit) {
    emit(state.copyWith(locale: event.locale));
  }

  void _isLoadingEvent(IsLoadingEvent event, Emitter<OptionPageState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }
}