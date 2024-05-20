import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
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
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.all(Radius.circular(15.w)),
        border: Border.all(color: AppColors.primaryFourthElementText),
      ),
      child: Row(
        children: [
          Container(
            width: 16.w,
            height: 16.w,
            margin: EdgeInsets.only(left: 17.w),
            child: Image.asset("assets/icons/$iconName.png"),
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
                hintStyle: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                fontFamily: AppFonts.Header3,
                color: AppColors.primaryText,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp,
              ),
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
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.all(Radius.circular(15.w)),
        border: Border.all(color: AppColors.primaryFourthElementText),
      ),
      child: Row(
        children: [
          Container(
            width: 16.w,
            height: 16.w,
            margin: EdgeInsets.only(left: 17.w),
            child: Image.asset("assets/icons/$iconName.png"),
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
                hintStyle: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                ),
                counterText: '',
              ),
              style: TextStyle(
                fontFamily: AppFonts.Header3,
                color: AppColors.primaryText,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp,
              ),
              autocorrect: false,
              maxLength: 30,
            ),
          )
        ],
      ));
}

Widget buildLogInAndRegButton(
    BuildContext context, String buttonName, String buttonType) {
  return GestureDetector(
    onTap: () {
      if (buttonType == "verify") {
        AlumniVerificationController(context: context)
            .hanldeAlumniVerification();
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
            ? AppColors.primaryElement
            : AppColors.primarySecondaryElement,
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
          style: TextStyle(
              fontFamily: AppFonts.Header1,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: buttonType == "verify"
                  ? AppColors.primaryBackground
                  : AppColors.primaryElement),
        ),
      ),
    ),
  );
}

Widget alumniVerification(BuildContext context) {
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
                    "assets/images/logos/logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                  child: Container(
                padding: EdgeInsets.only(bottom: 5.h),
                child: Text(
                  "BẮT ĐẦU",
                  style: TextStyle(
                    fontFamily: AppFonts.Header0,
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                  ),
                ),
              )),
              Center(
                  child: Container(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Text(
                  "Hãy thiết lập hồ sơ của bạn. Những thông tin này sẽ giúp chúng tôi xét duyệt tài khoản của bạn.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFonts.Header3,
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.normal,
                    fontSize: 12.sp,
                  ),
                ),
              )),
              SizedBox(
                height: 5.h,
              ),
              buildTextField("Mã số sinh viên", "studentId", "user", (value) {
                context
                    .read<AlumniVerificationBloc>()
                    .add(StudentIdEvent(value));
              }),
              SizedBox(
                height: 5.h,
              ),
              buildTextFieldStartYear("Năm nhập học", "startYear", "user",
                  (value) {
                context
                    .read<AlumniVerificationBloc>()
                    .add(StartYearEvent(value));
              }),
              SizedBox(
                height: 5.h,
              ),
              buildTextField(
                  "Trang cá nhân Facebook/ Linkedin", "socialMediaLink", "user",
                  (value) {
                context
                    .read<AlumniVerificationBloc>()
                    .add(SocialMediaLinkEvent(value));
              }),
            ],
          ),
        ),
        buildLogInAndRegButton(context, "XÁC THỰC", "verify"),
        buildLogInAndRegButton(context, "BỎ QUA", "skip"),
      ],
    ),
  );
}
