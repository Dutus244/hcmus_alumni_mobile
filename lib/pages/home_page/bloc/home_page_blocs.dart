import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page_events.dart';
import 'home_page_states.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageState()) {
    on<EventsEvent>(_eventsEvent);
    on<NewsEvent>(_newsEvent);
    on<HallOfFamesEvent>(_hallOfFamesEvent);
  }

  void _eventsEvent(EventsEvent event, Emitter<HomePageState> emit) {
    emit(state.copyWith(events: event.events));
  }

  void _newsEvent(NewsEvent event, Emitter<HomePageState> emit) {
    emit(state.copyWith(news: event.news));
  }

  void _hallOfFamesEvent(HallOfFamesEvent event, Emitter<HomePageState> emit) {
    emit(state.copyWith(hallOfFames: event.hallOfFames));
  }
}
