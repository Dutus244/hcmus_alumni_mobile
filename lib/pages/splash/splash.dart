import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/common/values/assets.dart';
import 'package:hcmus_alumni_mobile/common/values/constants.dart';

import '../../common/services/firebase_service.dart';
import '../../common/values/colors.dart';
import '../../global.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermisions();
    notificationServices.foregroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isRefreshToken();
    notificationServices.getDeviceToken().then((value) {
      print(value);
    });
    Timer(Duration(seconds: 2), () {
      if (Global.storageService.getDeviceFirstOpen()) {
        Global.storageService
            .setBool(AppConstants.DEVICE_OPEN_FIRST_TIME, false);
        Locale currentLocale = Localizations.localeOf(context);
        Global.storageService
            .setString(AppConstants.DEVICE_LANGUAGE, currentLocale.toString());
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/welcome", (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/signIn", (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Scaffold(
        body: Row(
          children: [
            Center(
              child: Container(
                width: 345.w,
                height: 345.w,
                child: Image.asset(
                  AppAssets.logoImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
