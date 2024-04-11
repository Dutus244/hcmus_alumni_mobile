import 'package:flutter_bloc/flutter_bloc.dart';

import 'news_event_page_events.dart';
import 'news_event_page_states.dart';

class NewsEventPageBloc extends Bloc<NewsEventPageEvent, NewsEventPageState> {
  NewsEventPageBloc() : super(NewsEventPageState()) {
    on<NewsEventPageIndexEvent>(_newsEventPageIndexEvent);
  }

  void _newsEventPageIndexEvent(
      NewsEventPageIndexEvent event, Emitter<NewsEventPageState> emit) {
    emit(state.copyWith(page: event.page));
  }
}
