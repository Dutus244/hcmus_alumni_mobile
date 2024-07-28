import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/assets.dart';
import 'package:hcmus_alumni_mobile/common/values/text_style.dart';

import '../../../common/values/colors.dart';
import '../forgot_password_controller.dart';
import '../bloc/forgot_password_events.dart';
import '../bloc/forgot_password_blocs.dart';

Widget buildTextFieldEmail(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  return Container(
      width: 325.w,
      height: 40.h,
      margin: EdgeInsets.only(bottom: 20.h, top: 30.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.all(Radius.circular(15.w)),
        border: Border.all(color: AppColors.primaryFourthElementText),
      ),
      child: Row(
        children: [
          Container(
            width: 235.w,
            height: 40.h,
            padding: EdgeInsets.only(top: 2.h, left: 20.w),
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
              obscureText: false,
              maxLength: 50,
            ),
          ),
          GestureDetector(
            onTap: () {
              ForgotPasswordController(context: context).handleResendCode();
            },
            child: Container(
              padding: EdgeInsets.only(left: 0.w),
              width: 70.w,
              height: 50.h,
              child: Row(
                children: [
                  Container(
                    width: 16.w,
                    height: 16.w,
                    margin: EdgeInsets.only(right: 10.w),
                    child: Image.asset(iconName),
                  ),
                  Text(
                    translate('send_again'),
                    style: AppTextStyle.small(context).underline(),
                  )
                ],
              ),
            ),
          )
        ],
      ));
}

Widget buildTextField(BuildContext context, String hintText, String textType, String iconName,
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
            width: 270.w,
            height: 40.h,
            padding: EdgeInsets.only(top: 2.h, left: 20.w),
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
              obscureText: false,
              maxLength: 8,
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
        ForgotPasswordController(context: context).handleEmailVerification();
      } else {
        Navigator.of(context).pushNamed("/signIn");
      }
    },
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(
          left: 25.w, right: 25.w, top: buttonType == "verify" ? 30.h : 20.h),
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
        child: Text(
          buttonName,
          style: AppTextStyle.medium(context).wSemiBold().withColor(
              buttonType == "verify"
                  ? AppColors.background
                  : AppColors.element),
        ),
      ),
    ),
  );
}

Widget forgotPassword(BuildContext context) {
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
                  translate('forgot_password').toUpperCase(),
                  style: AppTextStyle.medium(context).wSemiBold(),
                ),
              )),
              SizedBox(
                height: 5.h,
              ),
              buildTextFieldEmail(context, translate('email*'), "email", AppAssets.sendIconP,
                  (value) {
                context.read<ForgotPasswordBloc>().add(EmailEvent(value));
              }),
              SizedBox(
                height: 5.h,
              ),
              buildTextField(context, translate('authentication_code*'), "code", "",
                  (value) {
                context.read<ForgotPasswordBloc>().add(CodeEvent(value));
              }),
            ],
          ),
        ),
        buildVerifyAndBackButton(
            context, translate('verify').toUpperCase(), "verify"),
        buildVerifyAndBackButton(
            context, translate('back').toUpperCase(), "back"),
      ],
    ),
  );
}
