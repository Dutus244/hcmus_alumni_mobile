import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/assets.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/text_style.dart';
import '../bloc/change_password_forgot_blocs.dart';
import '../bloc/change_password_forgot_events.dart';
import '../change_password_forgot_controller.dart';

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
              obscureText: textType == "email" ? false : true,
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
      if (buttonType == "change") {
        ChangePasswordForgotController(context: context).hanldeChangePassword();
      } else {
        Navigator.of(context).pushNamed("forgotPassword");
      }
    },
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(
          left: 25.w, right: 25.w, top: buttonType == "change" ? 30.h : 20.h),
      decoration: BoxDecoration(
        color: buttonType == "change"
            ? AppColors.element
            : AppColors.elementLight,
        borderRadius: BorderRadius.circular(15.w),
        border: Border.all(
          color: buttonType == "change"
              ? Colors.transparent
              : AppColors.primaryFourthElementText,
        ),
      ),
      child: Center(
        child: Text(
          buttonName,
          style: AppTextStyle.medium(context).wSemiBold().withColor(
              buttonType == "change"
                  ? AppColors.background
                  : AppColors.element),
        ),
      ),
    ),
  );
}

Widget changePassword(BuildContext context) {
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
                padding: EdgeInsets.only(bottom: 15.h),
                child: Text(
                  translate('change_password').toUpperCase(),
                  style: AppTextStyle.medium(context).wSemiBold(),
                ),
              )),
              SizedBox(
                height: 5.h,
              ),
              buildTextField(context, translate('new_password*'), "password", AppAssets.lockIconP, (value) {
                context
                    .read<ChangePasswordForgotBloc>()
                    .add(PasswordEvent(value));
              }),
              SizedBox(
                height: 5.h,
              ),
              buildTextField(context, translate('re_new_password*'), "password", AppAssets.lockIconP,
                  (value) {
                context
                    .read<ChangePasswordForgotBloc>()
                    .add(RePasswordEvent(value));
              }),
            ],
          ),
        ),
        buildLogInAndRegButton(context, translate('change').toUpperCase(), "change"),
        buildLogInAndRegButton(context, translate('exit').toUpperCase(), "back"),
      ],
    ),
  );
}
