import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/common/values/constants.dart';
import 'package:hcmus_alumni_mobile/pages/splash/bloc/splash_blocs.dart';

import '../../common/values/colors.dart';
import '../../global.dart';
import 'bloc/splash_states.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      if (Global.storageService.getDeviceFirstOpen()) {
        Global.storageService.setBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME, false);
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/welcome", (route) => false);
      }
      else {
        Global.storageService.setBool(AppConstants.STORAGE_USER_IS_LOGGED_IN, false);
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/signIn", (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBackground,
      child: Scaffold(
        body: BlocBuilder<SplashBloc, SplashState>(builder: (context, state) {
          return Row(
            children: [
              Center(
                child: Container(
                  width: 345.w,
                  height: 345.w,
                  child: Image.asset(
                    "assets/images/logos/logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
