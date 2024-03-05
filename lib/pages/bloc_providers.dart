import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/register/bloc/register_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/sign_in/bloc/sign_in_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/splash/bloc/splash_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/welcome/bloc/welcome_blocs.dart';

class AppBlocProviders {
  static get allBlocProviders => [
        BlocProvider(
          create: (context) => SplashBloc(),
        ),
        BlocProvider(
          create: (context) => WelcomeBloc(),
        ),
        BlocProvider(
          create: (context) => SignInBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
      ];
}
