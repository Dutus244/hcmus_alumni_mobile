import 'package:flutter_bloc/flutter_bloc.dart';

import 'news_detail_events.dart';
import 'news_detail_states.dart';

class NewsDetailBloc extends Bloc<NewsDetailEvent, NewsDetailState> {
  NewsDetailBloc() : super(NewsDetailState()) {
    on<FontSizeEvent>(_fontSizeEvent);
    on<FontSizeResetEvent>(_fontSizeResetEvent);
    on<FontFamilyEvent>(_fontFamilyEvent);
  }

  void _fontSizeEvent(FontSizeEvent event, Emitter<NewsDetailState> emit) {
    emit(state.copyWith(fontSize: event.fontSize));
  }

  void _fontSizeResetEvent(
      FontSizeResetEvent event, Emitter<NewsDetailState> emit) {
    emit(state.copyWith(fontSize: 40));
  }

  void _fontFamilyEvent(FontFamilyEvent event, Emitter<NewsDetailState> emit) {
    emit(state.copyWith(fontFamily: event.fontFamily));
  }
}
