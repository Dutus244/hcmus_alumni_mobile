import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';

AppBar buildAppBar(BuildContext context, int route) {
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
                  "/myProfilePage", (route) => false,
                  arguments: {"route": route});
            },
            child: Container(
              padding: EdgeInsets.only(left: 0.w),
              child: SizedBox(
                width: 25.w,
                height: 25.h,
                child: SvgPicture.asset(
                  "assets/icons/back.svg",
                  width: 25.w,
                  height: 25.h,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
          Text(
            'Cài đặt',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppFonts.Header0,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: AppColors.secondaryHeader,
            ),
          ),
          Container(
            width: 25.w,
            color: Colors.transparent,
            child: Row(
              children: [],
            ),
          )
        ],
      ),
    ),
    centerTitle: true, // Đặt tiêu đề vào giữa
  );
}

Widget optionPage(BuildContext context, int route) {
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
