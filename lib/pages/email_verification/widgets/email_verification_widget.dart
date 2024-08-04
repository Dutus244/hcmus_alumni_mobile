import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/assets.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../../../common/values/text_style.dart';
import '../../../global.dart';
import '../bloc/email_verification_blocs.dart';
import '../bloc/email_verification_events.dart';
import '../email_verification_controller.dart';

Widget buildTextField(
    BuildContext context,
    String hintText,
    String textType,
    String iconName,
    void Function(String value)? func1,
    void Function()? func2) {
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
            width: 180.w,
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
                hintStyle: AppTextStyle.small(context)
                    .withColor(AppColors.secondaryElementText),
                counterText: '',
              ),
              style: AppTextStyle.small(context),
              autocorrect: false,
              obscureText: false,
              maxLength: 10,
            ),
          ),
          GestureDetector(
            onTap: func2,
            child: Container(
              padding: EdgeInsets.only(left: 10.w),
              width: 100.w,
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

Widget buildVerifyAndBackButton(
    BuildContext context, String buttonName, String buttonType) {
  return Container(
    width: 325.w,
    height: 50.h,
    margin: EdgeInsets.only(
        left: 25.w, right: 25.w, top: buttonType == "verify" ? 50.h : 20.h),
    child: ElevatedButton(
      onPressed: () {
        if (!BlocProvider.of<EmailVerificationBloc>(context).state.isLoading) {
          if (buttonType == "verify") {
            EmailVerificationController(context: context)
                .handleEmailVerification();
          } else {
            Navigator.of(context).pushNamed("/register");
          }
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor:
            buttonType == "verify" ? AppColors.background : AppColors.element,
        backgroundColor:
            buttonType == "verify" ? AppColors.element : AppColors.elementLight,
        minimumSize: Size(325.w, 50.h),
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.w),
          side: buttonType == "verify"
              ? BorderSide(color: Colors.transparent)
              : BorderSide(color: AppColors.primaryFourthElementText),
        ),
      ),
      child: Text(
        buttonName,
        style: AppTextStyle.medium(context).wSemiBold().withColor(
            buttonType == "verify" ? AppColors.background : AppColors.element),
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
                child: SizedBox(
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
                  translate('user_authentication').toUpperCase(),
                  style: AppTextStyle.medium(context).wSemiBold(),
                ),
              )),
              Center(
                  child: Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Text(
                  "${translate('authentication_code_sent')} ${Global.storageService.getUserEmail()}",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.small(context)
                      .italic()
                      .withColor(AppColors.element),
                ),
              )),
              SizedBox(
                height: 5.h,
              ),
              buildTextField(context, translate('authentication_code*'), "code",
                  AppAssets.sendIconP, (value) {
                context.read<EmailVerificationBloc>().add(CodeEvent(value));
              }, () {
                EmailVerificationController(context: context)
                    .handleResendCode();
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
