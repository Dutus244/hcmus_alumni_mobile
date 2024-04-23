import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/alumni_information.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_verification/alumni_verification.dart';
import 'package:hcmus_alumni_mobile/pages/application_page/application_page.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail/event_detail.dart';
import 'package:hcmus_alumni_mobile/pages/hof_page/hof_page.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail/news_detail.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail_write_comment/news_detail_write_comment.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/bloc/news_event_page_events.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/news_event_page.dart';
import 'package:hcmus_alumni_mobile/pages/sign_in/sign_in.dart';
import 'package:hcmus_alumni_mobile/pages/splash/splash.dart';
import 'package:hcmus_alumni_mobile/pages/welcome/welcome.dart';

import 'common/routes/pages.dart';
import 'global.dart';

Future<void> main() async {
  await Global.init();
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [...AppPages.allBlocProviders(context)],
        child: ScreenUtilInit(
          builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.white,
            )),
            home: Splash(),
            onGenerateRoute: AppPages.GenerateRouteSettings,
          ),
        ));
  }
}
