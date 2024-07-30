import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/main.dart';
import 'package:hcmus_alumni_mobile/pages/option_page/bloc/option_page_events.dart';
import 'package:hcmus_alumni_mobile/pages/option_page/option_page_controller.dart';

import '../../../common/services/socket_service.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/constants.dart';
import '../../../common/values/fonts.dart';
import '../../../global.dart';
import 'dart:io';

import '../bloc/option_page_blocs.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid
            ? EdgeInsets.only(top: 20.h)
            : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('option'),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppFonts.Header,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
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
            color: AppColors.elementLight,
            child: Container(
              margin: EdgeInsets.only(left: 10.w, top: 3.h, bottom: 3.h),
              child: Text(
                translate('account'),
                style: TextStyle(
                  color: AppColors.textBlack,
                  fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.Header,
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
                        translate('change_password'),
                        style: TextStyle(
                          color: AppColors.textBlack,
                          fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.w900,
                          fontFamily: AppFonts.Header,
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
          // Container(
          //   height: 24.h,
          //   margin: EdgeInsets.only(top: 10.h),
          //   color: AppColors.elementLight,
          //   child: Container(
          //     margin: EdgeInsets.only(left: 10.w, top: 3.h, bottom: 3.h),
          //     child: Text(
          //       translate('option'),
          //       style: TextStyle(
          //         color: AppColors.textBlack,
          //         fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
          //         fontWeight: FontWeight.bold,
          //         fontFamily: AppFonts.Header,
          //       ),
          //     ),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {},
          //   child: Container(
          //     color: Colors.transparent,
          //     margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Row(
          //           children: [
          //             SvgPicture.asset(
          //               "assets/icons/notification.svg",
          //               width: 16.w,
          //               height: 16.h,
          //               color: Colors.black,
          //             ),
          //             Container(
          //               width: 10.h,
          //             ),
          //             Text(
          //               translate('notification_setting'),
          //               style: TextStyle(
          //                 color: AppColors.textBlack,
          //                 fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
          //                 fontWeight: FontWeight.w900,
          //                 fontFamily: AppFonts.Header,
          //               ),
          //             ),
          //           ],
          //         ),
          //         SvgPicture.asset(
          //           "assets/icons/arrow_next.svg",
          //           width: 16.w,
          //           height: 16.h,
          //           color: Colors.black,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     showModalBottomSheet(
          //       isScrollControlled: true,
          //       context: context,
          //       builder: (ctx) => chooseLanguage(context),
          //     );
          //   },
          //   child: Container(
          //     color: Colors.transparent,
          //     margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Row(
          //           children: [
          //             SvgPicture.asset(
          //               "assets/icons/earth.svg",
          //               width: 16.w,
          //               height: 16.h,
          //               color: Colors.black,
          //             ),
          //             Container(
          //               width: 10.h,
          //             ),
          //             Text(
          //               translate('language_setting'),
          //               style: TextStyle(
          //                 color: AppColors.textBlack,
          //                 fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
          //                 fontWeight: FontWeight.w900,
          //                 fontFamily: AppFonts.Header,
          //               ),
          //             ),
          //           ],
          //         ),
          //         Text(
          //           BlocProvider.of<OptionPageBloc>(context).state.locale ==
          //                   "vi"
          //               ? translate('vietnamese')
          //               : translate('english'),
          //           style: TextStyle(
          //             color: AppColors.textBlack,
          //             fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
          //             fontWeight: FontWeight.normal,
          //             fontFamily: AppFonts.Header,
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // Container(
          //   height: 24.h,
          //   margin: EdgeInsets.only(top: 10.h),
          //   color: AppColors.elementLight,
          //   child: Container(
          //     margin: EdgeInsets.only(left: 10.w, top: 3.h, bottom: 3.h),
          //     child: Text(
          //       translate('rule'),
          //       style: TextStyle(
          //         color: AppColors.textBlack,
          //         fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
          //         fontWeight: FontWeight.bold,
          //         fontFamily: AppFonts.Header,
          //       ),
          //     ),
          //   ),
          // ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.pushNamed(context, '/termOfService');
          //   },
          //   child: Container(
          //     color: Colors.transparent,
          //     margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Row(
          //           children: [
          //             SvgPicture.asset(
          //               "assets/icons/term_of_service.svg",
          //               width: 16.w,
          //               height: 16.h,
          //               color: Colors.black,
          //             ),
          //             Container(
          //               width: 10.h,
          //             ),
          //             Text(
          //               translate('terms_of_service'),
          //               style: TextStyle(
          //                 color: AppColors.textBlack,
          //                 fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
          //                 fontWeight: FontWeight.w900,
          //                 fontFamily: AppFonts.Header,
          //               ),
          //             ),
          //           ],
          //         ),
          //         SvgPicture.asset(
          //           "assets/icons/arrow_next.svg",
          //           width: 16.w,
          //           height: 16.h,
          //           color: Colors.black,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              OptionPageController(context: context).handleSignOut();
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
                        translate('sign_out'),
                        style: TextStyle(
                          color: AppColors.textBlack,
                          fontSize: 16.sp / MediaQuery.of(context).textScaleFactor,
                          fontWeight: FontWeight.w900,
                          fontFamily: AppFonts.Header,
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
            color: AppColors.elementLight,
            child: Container(
              margin: EdgeInsets.only(left: 10.w, top: 3.h, bottom: 3.h),
              child: Center(
                child: Text(
                  'Alumverse HCMUS',
                  style: TextStyle(
                    color: AppColors.textBlack,
                    fontSize: 12.sp / MediaQuery.of(context).textScaleFactor,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.Header,
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

Widget chooseLanguage(
  BuildContext context,
) {
  return Container(
    height: 150.h,
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Center(
                  child: Text(
                    translate('choose_language'),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.Header,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            translate('vietnamese'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: 'vi',
                        groupValue: BlocProvider.of<OptionPageBloc>(context)
                            .state
                            .locale,
                        onChanged: (value) {
                          (context
                              .read<OptionPageBloc>()
                              .add(LocaleEvent(value!)));
                          MyApp.setLocale(context, Locale('vi'));
                          Global.storageService
                              .setString(AppConstants.DEVICE_LANGUAGE, 'vi');
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            translate('english'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.Header,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Radio(
                        value: 'en',
                        groupValue: BlocProvider.of<OptionPageBloc>(context)
                            .state
                            .locale,
                        onChanged: (value) {
                          (context
                              .read<OptionPageBloc>()
                              .add(LocaleEvent(value!)));
                          MyApp.setLocale(context, Locale('en'));
                          Global.storageService
                              .setString(AppConstants.DEVICE_LANGUAGE, 'en');
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
