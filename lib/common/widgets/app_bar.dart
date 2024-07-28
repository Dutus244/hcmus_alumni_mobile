import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../global.dart';
import '../values/colors.dart';
import '../values/fonts.dart';

AppBar buildAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: AppColors.background,
    automaticallyImplyLeading: false,
    title: Container(
      height: 40.h,
      margin: EdgeInsets.only(left: 0.w, right: 0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                "/applicationPage",
                (route) => false,
                arguments: {"route": 0},
              );
            },
            child: Container(
              padding: EdgeInsets.only(left: 0.w),
              child: SizedBox(
                width: 60.w,
                height: 120.h,
                child: Image.asset("assets/images/logos/logo.png"),
              ),
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppFonts.Header,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
              color: AppColors.secondaryHeader,
            ),
          ),
          Container(
            width: 60.w,
            child: Row(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/chatPage");
                      },
                      child: Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/icons/chat.png"))),
                      ),
                    ),
                    SizedBox(width: 10.w),
                  ],
                ),
                Container(
                  width: 20.w,
                  height: 20.w,
                  margin: EdgeInsets.only(),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/myProfilePage");
                      },
                      child: CircleAvatar(
                        radius: 10,
                        child: null,
                        backgroundImage: NetworkImage(
                            Global.storageService.getUserAvatarUrl()),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    ),
    centerTitle: true, // Đặt tiêu đề vào giữa
  );
}
