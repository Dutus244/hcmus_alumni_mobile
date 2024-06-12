import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../global.dart';
import '../values/colors.dart';
import '../values/fonts.dart';

AppBar buildAppBar(BuildContext context, String title, int route) {
  return AppBar(
    backgroundColor: AppColors.primaryBackground,
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
              fontFamily: AppFonts.Header0,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: AppColors.secondaryHeader,
            ),
          ),
          Container(
            width: 60.w,
            child: Row(
              children: [
                Global.storageService.permissionMessageCreate() ? Row(
                  children: [
                    GestureDetector(
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
                ) : Container(
                  width: 30.w,
                ),
                Container(
                  width: 20.w,
                  height: 20.w,
                  margin: EdgeInsets.only(),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                          "/myProfilePage"
                      );
                    },
                    child: CircleAvatar(
                      radius: 10,
                      child: null,
                      backgroundImage:
                      NetworkImage('https://storage.googleapis.com/hcmus-alumverse/images/users/avatar/c201bfdf3aadfe93c59f148a039322da99d8d96fdbba4055852689c761a9f8ea'),
                    )
                  ),
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
