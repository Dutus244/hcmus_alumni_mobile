import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page_events.dart';
import 'home_page_states.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageState()) {
    on<EventEvent>(_eventEvent);
    on<NewsEvent>(_newsEvent);
  }

  void _eventEvent(EventEvent event, Emitter<HomePageState> emit) {
    emit(state.copyWith(event: event.event));
  }

  void _newsEvent(NewsEvent event, Emitter<HomePageState> emit) {
    emit(state.copyWith(news: event.news));
  }
}
