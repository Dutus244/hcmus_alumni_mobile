import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/text_style.dart';

import '../../../common/values/assets.dart';
import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../alumni_verification_controller.dart';
import '../bloc/alumni_verification_blocs.dart';
import '../bloc/alumni_verification_events.dart';

Widget buildTextField(BuildContext context, String hintText, String textType,
    String iconName, void Function(String value)? func) {
  return Container(
      width: 325.w,
      height: 40.h,
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.all(Radius.circular(15.w)),
        border: Border.all(color: AppColors.primaryFourthElementText),
      ),
      child: Row(
        children: [
          Container(
            width: 16.w,
            height: 16.w,
            margin: EdgeInsets.only(left: 17.w),
            child: Image.asset(iconName),
          ),
          Container(
            width: 270.w,
            height: 40.h,
            padding: EdgeInsets.only(top: 2.h, left: 10.w),
            child: TextField(
              onChanged: (value) => func!(value),
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                hintStyle: AppTextStyle.small(context)
                    .withColor(AppColors.secondaryElementText),
                counterText: '',
              ),
              style: AppTextStyle.small(context),
              autocorrect: false,
              maxLength: textType == 'studentId' ? 8 : 100,
            ),
          )
        ],
      ));
}

Widget buildTextFieldStartYear(BuildContext context, String hintText,
    String textType, String iconName, void Function(int value)? func) {
  return Container(
      width: 325.w,
      height: 40.h,
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.all(Radius.circular(15.w)),
        border: Border.all(color: AppColors.primaryFourthElementText),
      ),
      child: Row(
        children: [
          Container(
            width: 16.w,
            height: 16.w,
            margin: EdgeInsets.only(left: 17.w),
            child: Image.asset(iconName),
          ),
          Container(
            width: 270.w,
            height: 40.h,
            padding: EdgeInsets.only(top: 2.h, left: 10.w),
            child: TextField(
              onChanged: (value) => func!(int.parse(value)),
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                hintStyle: AppTextStyle.small(context)
                    .withColor(AppColors.secondaryElementText),
                counterText: '',
              ),
              style: AppTextStyle.small(context),
              autocorrect: false,
              maxLength: 30,
            ),
          )
        ],
      ));
}

Widget buildLogInAndRegButton(BuildContext context, String buttonName,
    String buttonType, String fullName, File? avatar) {
  return GestureDetector(
    onTap: () {
      if (buttonType == "verify") {
        AlumniVerificationController(context: context)
            .handleAlumniVerification(fullName, avatar);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/applicationPage", arguments: {"route": 0}, (route) => false);
      }
    },
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(
          left: 25.w, right: 25.w, top: buttonType == "verify" ? 10.h : 10.h),
      decoration: BoxDecoration(
        color:
            buttonType == "verify" ? AppColors.element : AppColors.elementLight,
        borderRadius: BorderRadius.circular(15.w),
        border: Border.all(
          color: buttonType == "verify"
              ? Colors.transparent
              : AppColors.primaryFourthElementText,
        ),
      ),
      child: Center(
        child: Text(buttonName,
            style: AppTextStyle.medium(context).wSemiBold().withColor(
                buttonType == "verify"
                    ? AppColors.background
                    : AppColors.element)),
      ),
    ),
  );
}

Widget chooseFaculty(BuildContext context) {
  return Container(
    height: 450.h,
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
                    translate('choose_faculty'),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp / MediaQuery.of(context).textScaleFactor,
                      fontWeight: FontWeight.normal,
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
                            'Công nghệ thông tin',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp /
                                  MediaQuery.of(context).textScaleFactor,
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
                        value: 1,
                        groupValue:
                            BlocProvider.of<AlumniVerificationBloc>(context)
                                .state
                                .facultyId,
                        onChanged: (value) {
                          (context
                              .read<AlumniVerificationBloc>()
                              .add(FacultyIdEvent(value!)));
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
                            'Vật lý – Vật lý kỹ thuật',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp /
                                  MediaQuery.of(context).textScaleFactor,
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
                        value: 2,
                        groupValue:
                            BlocProvider.of<AlumniVerificationBloc>(context)
                                .state
                                .facultyId,
                        onChanged: (value) {
                          (context
                              .read<AlumniVerificationBloc>()
                              .add(FacultyIdEvent(value!)));
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
                            'Địa chất',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp /
                                  MediaQuery.of(context).textScaleFactor,
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
                        value: 3,
                        groupValue:
                            BlocProvider.of<AlumniVerificationBloc>(context)
                                .state
                                .facultyId,
                        onChanged: (value) {
                          (context
                              .read<AlumniVerificationBloc>()
                              .add(FacultyIdEvent(value!)));
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
                            'Toán – Tin học',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp /
                                  MediaQuery.of(context).textScaleFactor,
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
                        value: 4,
                        groupValue:
                            BlocProvider.of<AlumniVerificationBloc>(context)
                                .state
                                .facultyId,
                        onChanged: (value) {
                          (context
                              .read<AlumniVerificationBloc>()
                              .add(FacultyIdEvent(value!)));
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
                            'Điện tử - Viễn thông',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp /
                                  MediaQuery.of(context).textScaleFactor,
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
                        value: 5,
                        groupValue:
                            BlocProvider.of<AlumniVerificationBloc>(context)
                                .state
                                .facultyId,
                        onChanged: (value) {
                          (context
                              .read<AlumniVerificationBloc>()
                              .add(FacultyIdEvent(value!)));
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
                            'Khoa học & Công nghệ Vật liệu',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp /
                                  MediaQuery.of(context).textScaleFactor,
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
                        value: 6,
                        groupValue:
                            BlocProvider.of<AlumniVerificationBloc>(context)
                                .state
                                .facultyId,
                        onChanged: (value) {
                          (context
                              .read<AlumniVerificationBloc>()
                              .add(FacultyIdEvent(value!)));
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
                            'Hóa học',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp /
                                  MediaQuery.of(context).textScaleFactor,
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
                        value: 7,
                        groupValue:
                            BlocProvider.of<AlumniVerificationBloc>(context)
                                .state
                                .facultyId,
                        onChanged: (value) {
                          (context
                              .read<AlumniVerificationBloc>()
                              .add(FacultyIdEvent(value!)));
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
                            'Sinh học – Công nghệ Sinh học',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp /
                                  MediaQuery.of(context).textScaleFactor,
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
                        value: 8,
                        groupValue:
                            BlocProvider.of<AlumniVerificationBloc>(context)
                                .state
                                .facultyId,
                        onChanged: (value) {
                          (context
                              .read<AlumniVerificationBloc>()
                              .add(FacultyIdEvent(value!)));
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
                            'Môi trường',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp /
                                  MediaQuery.of(context).textScaleFactor,
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
                        value: 9,
                        groupValue:
                            BlocProvider.of<AlumniVerificationBloc>(context)
                                .state
                                .facultyId,
                        onChanged: (value) {
                          (context
                              .read<AlumniVerificationBloc>()
                              .add(FacultyIdEvent(value!)));
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

Widget buildTextFieldFaculty(BuildContext context, String iconName) {
  String faculty = translate('choose_faculty');
  switch (BlocProvider.of<AlumniVerificationBloc>(context).state.facultyId) {
    case 1:
      faculty = "Công nghệ thông tin";
    case 2:
      faculty = "Vật lý – Vật lý kỹ thuật";
    case 3:
      faculty = "Địa chất";
    case 4:
      faculty = "Toán – Tin học";
    case 5:
      faculty = "Điện tử - Viễn thông";
    case 6:
      faculty = "Khoa học & Công nghệ Vật liệu";
    case 7:
      faculty = "Hóa học";
    case 8:
      faculty = "Sinh học – Công nghệ Sinh học";
    case 9:
      faculty = "Môi trường";
  }

  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => chooseFaculty(context),
      );
    },
    child: Container(
        width: 325.w,
        height: 40.h,
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
          border: Border.all(color: AppColors.primaryFourthElementText),
        ),
        child: Row(
          children: [
            Container(
              width: 16.w,
              height: 16.w,
              margin: EdgeInsets.only(left: 17.w),
              child: Image.asset(iconName),
            ),
            Container(
              width: 250.w,
              height: 40.h,
              margin: EdgeInsets.only(left: 10.w, top: 10.h),
              child: Text(
                faculty,
                style: AppTextStyle.small(context),
              ),
            )
          ],
        )),
  );
}

Widget alumniVerification(BuildContext context, String fullName, File? avatar) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 25.w, right: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 200.w,
                  height: 200.w,
                  child: Image.asset(
                    AppAssets.logoImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                  child: Container(
                padding: EdgeInsets.only(bottom: 0.h),
                child: Text(
                  translate('start').toUpperCase(),
                  style: AppTextStyle.medium(context).wSemiBold(),
                ),
              )),
              Center(
                  child: Container(
                padding: EdgeInsets.only(bottom: 5.h),
                child: Text(
                  translate('alumni_information_verify_title'),
                  textAlign: TextAlign.center,
                  style: AppTextStyle.small(context),
                ),
              )),
              SizedBox(
                height: 5.h,
              ),
              buildTextField(context, translate('student_id'), "studentId",
                  AppAssets.userIconP, (value) {
                context
                    .read<AlumniVerificationBloc>()
                    .add(StudentIdEvent(value));
              }),
              SizedBox(
                height: 5.h,
              ),
              buildTextFieldFaculty(context, AppAssets.userIconP),
              SizedBox(
                height: 5.h,
              ),
              buildTextFieldStartYear(context, translate('year_admission'),
                  "startYear", AppAssets.userIconP, (value) {
                context
                    .read<AlumniVerificationBloc>()
                    .add(StartYearEvent(value));
              }),
              SizedBox(
                height: 5.h,
              ),
              buildTextField(context, translate('social_link'),
                  "socialMediaLink", AppAssets.userIconP, (value) {
                context
                    .read<AlumniVerificationBloc>()
                    .add(SocialMediaLinkEvent(value));
              }),
            ],
          ),
        ),
        buildLogInAndRegButton(context, translate("verify").toUpperCase(),
            "verify", fullName, avatar),
        buildLogInAndRegButton(
            context, translate("skip").toUpperCase(), "skip", fullName, avatar),
      ],
    ),
  );
}
