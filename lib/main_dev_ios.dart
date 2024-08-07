import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/pages/splash/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common/routes/pages.dart';
import 'global.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await Global.init();
  await dotenv.load(fileName: '.env.dev.ios');
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'vi',
    supportedLocales: ['vi'],
  );
  delegate.changeLocale(Locale(Global.storageService.getDeviceLanguage()));
  runApp(LocalizedApp(delegate, MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    LocalizedApp.of(context).delegate.changeLocale(newLocale);
  }

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    setLocale(context, Locale(Global.storageService.getDeviceLanguage()));

    return MultiBlocProvider(
      providers: [
        ...AppPages.allBlocProviders(context),
      ],
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          title: 'HCMUS ALUMNI',
          navigatorKey: navigatorKey,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            localizationDelegate
          ],
          supportedLocales: localizationDelegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.white,
            ),
          ),
          home: Splash(),
          onGenerateRoute: AppPages.GenerateRouteSettings,
        ),
      ),
    );
  }
}
