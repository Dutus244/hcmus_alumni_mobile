import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/text_style.dart';

import '../../../common/values/assets.dart';
import '../../../common/values/colors.dart';
import '../alumni_verification_controller.dart';
import '../bloc/alumni_verification_blocs.dart';
import '../bloc/alumni_verification_events.dart';

Widget buildTextField(String hintText, String textType, String iconName,
    void Function(String value)? func) {
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
                hintStyle: AppTextStyle.small().withColor(AppColors.secondaryElementText),
                counterText: '',
              ),
              style: AppTextStyle.small(),
              autocorrect: false,
              maxLength: textType == 'studentId' ? 8 : 100,
            ),
          )
        ],
      ));
}

Widget buildTextFieldStartYear(String hintText, String textType,
    String iconName, void Function(int value)? func) {
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
                hintStyle: AppTextStyle.small().withColor(AppColors.secondaryElementText),
                counterText: '',
              ),
              style: AppTextStyle.small(),
              autocorrect: false,
              maxLength: 30,
            ),
          )
        ],
      ));
}

Widget buildLogInAndRegButton(
    BuildContext context, String buttonName, String buttonType, String fullName, File? avatar) {
  return GestureDetector(
    onTap: () {
      if (buttonType == "verify") {
        AlumniVerificationController(context: context)
            .handleAlumniVerification(fullName, avatar);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/applicationPage", (route) => false);
      }
    },
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(
          left: 25.w, right: 25.w, top: buttonType == "verify" ? 20.h : 20.h),
      decoration: BoxDecoration(
        color: buttonType == "verify"
            ? AppColors.element
            : AppColors.elementLight,
        borderRadius: BorderRadius.circular(15.w),
        border: Border.all(
          color: buttonType == "verify"
              ? Colors.transparent
              : AppColors.primaryFourthElementText,
        ),
      ),
      child: Center(
        child: Text(
          buttonName,
          style: AppTextStyle.medium().wSemiBold().withColor(buttonType == "verify"
              ? AppColors.background
              : AppColors.element)
        ),
      ),
    ),
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
                  width: 230.w,
                  height: 230.w,
                  child: Image.asset(
                    AppAssets.logoImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                  child: Container(
                padding: EdgeInsets.only(bottom: 5.h),
                child: Text(
                  translate('start').toUpperCase(),
                  style: AppTextStyle.medium().wSemiBold(),
                ),
              )),
              Center(
                  child: Container(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Text(
                  translate('alumni_information_verify_title'),
                  textAlign: TextAlign.center, style: AppTextStyle.small(),
                ),
              )),
              SizedBox(
                height: 5.h,
              ),
              buildTextField(translate('student_id'), "studentId", AppAssets.userIconP, (value) {
                context
                    .read<AlumniVerificationBloc>()
                    .add(StudentIdEvent(value));
              }),
              SizedBox(
                height: 5.h,
              ),
              buildTextFieldStartYear(translate('year_admission'), "startYear", AppAssets.userIconP,
                  (value) {
                context
                    .read<AlumniVerificationBloc>()
                    .add(StartYearEvent(value));
              }),
              SizedBox(
                height: 5.h,
              ),
              buildTextField(
                  translate('social_link'), "socialMediaLink", AppAssets.userIconP,
                  (value) {
                context
                    .read<AlumniVerificationBloc>()
                    .add(SocialMediaLinkEvent(value));
              }),
            ],
          ),
        ),
        buildLogInAndRegButton(context, translate("verify").toUpperCase(), "verify", fullName, avatar),
        buildLogInAndRegButton(context, translate("skip").toUpperCase(), "skip", fullName, avatar),
      ],
    ),
  );
}
