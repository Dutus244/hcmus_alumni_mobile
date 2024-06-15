import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/constants.dart';
import '../../../common/values/fonts.dart';
import '../../../global.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.primaryBackground,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: Text(
          'Cài đặt',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.Header0,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: AppColors.secondaryHeader,
          ),
        ),
      ),
    ),
  );
}

Widget optionPage(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
          child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            height: 24.h,
            color: AppColors.primarySecondaryElement,
            child: Container(
              margin: EdgeInsets.only(left: 10.w, top: 3.h, bottom: 3.h),
              child: Text(
                'Tài khoản',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.Header2,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/changePassword');
            },
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/lock.svg",
                        width: 16.w,
                        height: 16.h,
                        color: Colors.black,
                      ),
                      Container(
                        width: 10.h,
                      ),
                      Text(
                        'Đổi mật khẩu',
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w900,
                          fontFamily: AppFonts.Header2,
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    "assets/icons/arrow_next.svg",
                    width: 16.w,
                    height: 16.h,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 24.h,
            margin: EdgeInsets.only(top: 10.h),
            color: AppColors.primarySecondaryElement,
            child: Container(
              margin: EdgeInsets.only(left: 10.w, top: 3.h, bottom: 3.h),
              child: Text(
                'Cài đặt',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.Header2,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/notification.svg",
                        width: 16.w,
                        height: 16.h,
                        color: Colors.black,
                      ),
                      Container(
                        width: 10.h,
                      ),
                      Text(
                        'Cài đặt thông báo',
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w900,
                          fontFamily: AppFonts.Header2,
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    "assets/icons/arrow_next.svg",
                    width: 16.w,
                    height: 16.h,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/earth.svg",
                        width: 16.w,
                        height: 16.h,
                        color: Colors.black,
                      ),
                      Container(
                        width: 10.h,
                      ),
                      Text(
                        'Cài đặt ngôn ngữ',
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w900,
                          fontFamily: AppFonts.Header2,
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    "assets/icons/arrow_next.svg",
                    width: 16.w,
                    height: 16.h,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 24.h,
            margin: EdgeInsets.only(top: 10.h),
            color: AppColors.primarySecondaryElement,
            child: Container(
              margin: EdgeInsets.only(left: 10.w, top: 3.h, bottom: 3.h),
              child: Text(
                'Điều khoản',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.Header2,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/termOfService');
            },
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/term_of_service.svg",
                        width: 16.w,
                        height: 16.h,
                        color: Colors.black,
                      ),
                      Container(
                        width: 10.h,
                      ),
                      Text(
                        'Điều khoản dịch vụ',
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w900,
                          fontFamily: AppFonts.Header2,
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    "assets/icons/arrow_next.svg",
                    width: 16.w,
                    height: 16.h,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Global.storageService
                  .setString(AppConstants.STORAGE_USER_AUTH_TOKEN, '');
              Global.storageService
                  .setBool(AppConstants.STORAGE_USER_IS_LOGGED_IN, false);
              Global.storageService
                  .setBool(AppConstants.STORAGE_USER_REMEMBER_LOGIN, false);
              Global.storageService
                  .setString(AppConstants.STORAGE_USER_EMAIL, '');
              Global.storageService
                  .setString(AppConstants.STORAGE_USER_PASSWORD, '');
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/signIn", (route) => false);
            },
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/sign_out.svg",
                        width: 16.w,
                        height: 16.h,
                        color: Colors.black,
                      ),
                      Container(
                        width: 10.h,
                      ),
                      Text(
                        'Đăng xuất',
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w900,
                          fontFamily: AppFonts.Header2,
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    "assets/icons/arrow_next.svg",
                    width: 16.w,
                    height: 16.h,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 24.h,
            margin: EdgeInsets.only(top: 10.h),
            color: AppColors.primarySecondaryElement,
            child: Container(
              margin: EdgeInsets.only(left: 10.w, top: 3.h, bottom: 3.h),
              child: Center(
                child: Text(
                  'Alumverse HCMUS',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.Header2,
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    ],
  );
}
