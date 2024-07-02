import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/services/firebase_service.dart';
import 'package:hcmus_alumni_mobile/pages/application_page/application_page.dart';
import 'package:hcmus_alumni_mobile/pages/splash/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hcmus_alumni_mobile/pages/write_post_advise/write_post_advise.dart';

import 'common/routes/pages.dart';
import 'global.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyCLggDtQppE4ePbYut9yxReKjVrTsA6MlI',
        appId: '1:436562093949:android:a411ef450c3297a50a4e14',
        messagingSenderId: '436562093949',
        projectId: 'alumverse-23173',
        storageBucket: 'alumverse-23173.appspot.com',
      ),
    );
  } else if (Platform.isIOS) {
    await Firebase.initializeApp();
  }

  await FirebaseService().initNotifications();
  await Global.init();
  await dotenv.load(fileName: '.env');
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'vi',
    supportedLocales: ['vi', 'en'],
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
