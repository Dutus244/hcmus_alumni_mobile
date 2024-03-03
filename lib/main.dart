import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/splash/bloc/splash_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/splash/splash.dart';
import 'package:hcmus_alumni_mobile/pages/welcome/bloc/welcome_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/welcome/welcome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            // lazy: false,
            create: (context) => SplashBloc(),
          ),
          BlocProvider(
            // lazy: false,
            create: (context) => WelcomeBloc(),
          ),
        ],
        child: ScreenUtilInit(
          builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
                  elevation: 0,
                  backgroundColor: Colors.white,
                )),
            home: Splash(),
            routes: {
              "welcome": (context) => const Welcome(),
            },
          ),
        ));
  }
}
