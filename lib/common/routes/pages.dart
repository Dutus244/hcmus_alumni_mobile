import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/advise_page/advise_page.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/alumni_information.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_information/bloc/alumni_information_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_verification/alumni_verification.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_verification/bloc/alumni_verification_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/application_page/application_page.dart';
import 'package:hcmus_alumni_mobile/pages/application_page/bloc/application_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/change_password_forgot/bloc/change_password_forgot_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/change_password_forgot/change_password_forgot.dart';
import 'package:hcmus_alumni_mobile/pages/email_verification/bloc/email_verification_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/email_verification/email_verification.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail/event_detail.dart';
import 'package:hcmus_alumni_mobile/pages/forgot_password/bloc/forgot_password_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/forgot_password/forgot_password.dart';
import 'package:hcmus_alumni_mobile/pages/hof_page/bloc/hof_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/hof_page/hof_page.dart';
import 'package:hcmus_alumni_mobile/pages/home_page/bloc/home_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/home_page/home_page.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail/bloc/news_detail_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail/news_detail.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail_write_comment/news_detail_write_comment.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/bloc/news_event_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/news_event_page.dart';
import 'package:hcmus_alumni_mobile/pages/sign_in/sign_in.dart';
import 'package:hcmus_alumni_mobile/pages/splash/bloc/splash_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/splash/splash.dart';
import 'package:hcmus_alumni_mobile/pages/welcome/bloc/welcome_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/welcome/welcome.dart';

import '../../pages/event_detail/bloc/event_detail_blocs.dart';
import '../../pages/register/bloc/register_blocs.dart';
import '../../pages/register/register.dart';
import '../../pages/sign_in/bloc/sign_in_blocs.dart';
import 'names.dart';

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
          route: AppRoutes.SPLASH,
          page: const Splash(),
          bloc: BlocProvider(
            create: (_) => SplashBloc(),
          )),
      PageEntity(
          route: AppRoutes.WELCOME,
          page: const Welcome(),
          bloc: BlocProvider(
            create: (_) => WelcomeBloc(),
          )),
      PageEntity(
          route: AppRoutes.SIGN_IN,
          page: const SignIn(),
          bloc: BlocProvider(
            create: (_) => SignInBloc(),
          )),
      PageEntity(
          route: AppRoutes.REGISTER,
          page: const Register(),
          bloc: BlocProvider(
            create: (_) => RegisterBloc(),
          )),
      PageEntity(
          route: AppRoutes.EMAIL_VERIFICATION,
          page: const EmailVerification(),
          bloc: BlocProvider(
            create: (_) => EmailVerificationBloc(),
          )),
      PageEntity(
          route: AppRoutes.ALUMNI_VERIFICATION,
          page: const AlumniVerification(),
          bloc: BlocProvider(
            create: (_) => AlumniVerificationBloc(),
          )),
      PageEntity(
          route: AppRoutes.ALUMNI_INFORMATION,
          page: const AlumniInformation(),
          bloc: BlocProvider(
            create: (_) => AlumniInformationBloc(),
          )),
      PageEntity(
          route: AppRoutes.FORGOT_PASSWORD,
          page: const ForgotPassword(),
          bloc: BlocProvider(
            create: (_) => ForgotPasswordBloc(),
          )),
      PageEntity(
          route: AppRoutes.CHANGE_FORGOT_PASSWORD,
          page: const ChangePasswordForgot(),
          bloc: BlocProvider(
            create: (_) => ChangePasswordForgotBloc(),
          )),
      PageEntity(
          route: AppRoutes.APPLICATION_PAGE,
          page: const ApplicationPage(),
          bloc: BlocProvider(
            create: (_) => ApplicationPageBloc(),
          )),
      PageEntity(
          route: AppRoutes.HOME_PAGE,
          page: const HomePage(),
          bloc: BlocProvider(
            create: (_) => HomePageBloc(),
          )),
      PageEntity(
          route: AppRoutes.NEWS_EVENT_PAGE,
          page: NewsEventPage(
            page: 0,
          ),
          bloc: BlocProvider(
            create: (_) => NewsEventPageBloc(),
          )),
      PageEntity(
          route: AppRoutes.ADVISE_PAGE,
          page: const AdvisePage(),
          bloc: BlocProvider(
            create: (_) => ApplicationPageBloc(),
          )),
      PageEntity(
          route: AppRoutes.HOF_PAGE,
          page: const HofPage(),
          bloc: BlocProvider(
            create: (_) => HofPageBloc(),
          )),
      PageEntity(
          route: AppRoutes.NEWS_DETAIL,
          page: const NewsDetail(),
          bloc: BlocProvider(
            create: (_) => NewsDetailBloc(),
          )),
      PageEntity(
        route: AppRoutes.NEWS_DETAIL_WRITE_COMMENT,
        page: const NewsDetailWriteComment(),
        // bloc: BlocProvider(
        //   create: (_) => NewsDetailBloc(),
        // )
      ),
      PageEntity(
          route: AppRoutes.EVENT_DETAIL,
          page: const EventDetail(),
          bloc: BlocProvider(
            create: (_) => EventDetailBloc(),
          )),
    ];
  }

  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      if (bloc.bloc != null) {
        blocProviders.add(bloc.bloc);
      }
    }
    return blocProviders;
  }

  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    return MaterialPageRoute(builder: (_) => SignIn(), settings: settings);
  }
}

class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({
    required this.route,
    required this.page,
    this.bloc,
  });
}
