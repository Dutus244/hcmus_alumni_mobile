import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../global.dart';
import '../bloc/email_verification_blocs.dart';
import '../bloc/email_verification_events.dart';
import '../email_verification_controller.dart';

Widget buildTextField(String hintText, String textType, String iconName,
    void Function(String value)? func1, void Function()? func2) {
  return Container(
      width: 325.w,
      height: 40.h,
      margin: EdgeInsets.only(bottom: 20.h, top: 30.h),
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.all(Radius.circular(15.w)),
        border: Border.all(color: AppColors.primaryFourthElementText),
      ),
      child: Row(
        children: [
          Container(
            width: 200.w,
            height: 40.h,
            padding: EdgeInsets.only(top: 2.h, left: 20.w),
            child: TextField(
              onChanged: (value) => func1!(value),
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
              obscureText: false,
              maxLength: 10,
            ),
          ),
          GestureDetector(
            onTap: func2,
            child: Container(
              padding: EdgeInsets.only(left: 20.w),
              width: 100.w,
              height: 50.h,
              child: Row(
                children: [
                  Container(
                    width: 16.w,
                    height: 16.w,
                    margin: EdgeInsets.only(right: 10.w),
                    child: Image.asset("assets/icons/$iconName.png"),
                  ),
                  Text(
                    "Gửi lại",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: AppColors.primaryText,
                      decorationColor: AppColors.primaryText,
                      decoration: TextDecoration.underline,
                      fontSize: 12.sp,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ));
}

Widget buildVerifyAndBackButton(
    BuildContext context, String buttonName, String buttonType) {
  return GestureDetector(
    onTap: () {
      if (buttonType == "verify") {
        EmailVerificationController(context: context).handleEmailVerification();
      } else {
        Navigator.of(context).pushNamed("/register");
      }
    },
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(
          left: 25.w, right: 25.w, top: buttonType == "verify" ? 50.h : 20.h),
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

Widget emailVerification(BuildContext context) {
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
                  "XÁC THỰC NGƯỜI DÙNG",
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
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Text(
                  "Mã xác thực đã được gửi đến ${Global.storageService.getUserEmail()}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFonts.Header3,
                    color: AppColors.primaryElement,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                    fontSize: 11.sp,
                  ),
                ),
              )),
              SizedBox(
                height: 5.h,
              ),
              buildTextField("Mã xác thực  *", "code", "send", (value) {
                context.read<EmailVerificationBloc>().add(CodeEvent(value));
              }, () {
                EmailVerificationController(context: context)
                    .handleResendCode();
              }),
            ],
          ),
        ),
        buildVerifyAndBackButton(context, "XÁC THỰC", "verify"),
        buildVerifyAndBackButton(context, "TRỞ VỀ", "back"),
      ],
    ),
  );
}
