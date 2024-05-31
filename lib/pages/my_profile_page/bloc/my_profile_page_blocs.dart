import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_profile_page_events.dart';
import 'my_profile_page_states.dart';

class MyProfilePageBloc extends Bloc<MyProfilePageEvent, MyProfilePageState> {
  MyProfilePageBloc() : super(MyProfilePageState()) {

  }
}