import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/splash/bloc/splash_events.dart';
import 'package:hcmus_alumni_mobile/pages/splash/bloc/splash_states.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState()) {}
}
