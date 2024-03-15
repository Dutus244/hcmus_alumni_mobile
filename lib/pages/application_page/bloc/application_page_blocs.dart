import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/application_page/bloc/application_page_events.dart';
import 'package:hcmus_alumni_mobile/pages/application_page/bloc/application_page_states.dart';

class ApplicationPageBloc
    extends Bloc<ApplicationPageEvent, ApplicationPageState> {
  ApplicationPageBloc() : super(const ApplicationPageState()) {
    on<TriggerApplicationPageEvent>((event, emit) {
      emit(ApplicationPageState(index: event.index));
    });
  }
}
