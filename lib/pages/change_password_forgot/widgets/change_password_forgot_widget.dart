import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/assets.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/text_style.dart';
import '../../../global.dart';
import '../bloc/change_password_forgot_blocs.dart';
import '../bloc/change_password_forgot_events.dart';
import '../change_password_forgot_controller.dart';

Widget buildTextFieldCode(
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

Widget buildTextFieldPassword(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  return Container(
    width: 325.w,
    height: 40.h,
    margin: textType == "email"
        ? EdgeInsets.only(bottom: 20.h)
        : EdgeInsets.only(bottom: 10.h),
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
          child: Image.asset("assets/icons/${iconName}.png"),
        ),
        Container(
          width: textType == "email" ? 270.w : 230.w,
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
            obscureText: !BlocProvider.of<ChangePasswordForgotBloc>(context)
                .state
                .showPass,
            maxLength: textType == "email" ? 50 : 20,
          ),
        ),
        IconButton(
          icon: Icon(
            BlocProvider.of<ChangePasswordForgotBloc>(context).state.showPass
                ? Icons.visibility
                : Icons.visibility_off,
            color: AppColors.primaryFourthElementText,
            size: 20.w,
          ),
          onPressed: () {
            context.read<ChangePasswordForgotBloc>().add(ShowPassEvent(
                !BlocProvider.of<ChangePasswordForgotBloc>(context)
                    .state
                    .showPass));
          },
        ),
      ],
    ),
  );
}

Widget buildLogInAndRegButton(
    BuildContext context, String buttonName, String buttonType, String email) {
  return Container(
    width: 325.w,
    height: 50.h,
    margin: EdgeInsets.only(
        left: 25.w, right: 25.w, top: buttonType == "register" ? 30.h : 20.h),
    child: ElevatedButton(
      onPressed: () {
        if (!BlocProvider.of<ChangePasswordForgotBloc>(context)
            .state
            .isLoading) {
          if (buttonType == "change") {
            ChangePasswordForgotController(context: context)
                .handleChangePassword(email);
          } else {
            Navigator.of(context).pushNamed("/forgotPassword");
          }
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor:
            buttonType == "change" ? AppColors.background : AppColors.element,
        backgroundColor:
            buttonType == "change" ? AppColors.element : AppColors.elementLight,
        minimumSize: Size(325.w, 50.h),
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.w),
          side: buttonType == "change"
              ? BorderSide(color: Colors.transparent)
              : BorderSide(color: AppColors.primaryFourthElementText),
        ),
      ),
      child: Text(
        buttonName,
        style: AppTextStyle.medium(context).wSemiBold().withColor(
            buttonType == "change" ? AppColors.background : AppColors.element),
      ),
    ),
  );
}

Widget changePassword(BuildContext context, String email) {
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
              Center(
                  child: Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Text(
                  "${translate('authentication_code_sent')} ${email}",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.small(context)
                      .italic()
                      .withColor(AppColors.element),
                ),
              )),
              SizedBox(
                height: 5.h,
              ),
              buildTextFieldCode(context, translate('authentication_code*'),
                  "code", AppAssets.sendIconP, (value) {
                context.read<ChangePasswordForgotBloc>().add(CodeEvent(value));
              }, () {
                ChangePasswordForgotController(context: context)
                    .handleResendCode(email);
              }),
              SizedBox(
                height: 5.h,
              ),
              buildTextFieldPassword(
                  context, translate('new_password*'), "password", "lock",
                  (value) {
                context
                    .read<ChangePasswordForgotBloc>()
                    .add(PasswordEvent(value));
              }),
              SizedBox(
                height: 5.h,
              ),
              buildTextFieldPassword(
                  context, translate('re_new_password*'), "password", "lock",
                  (value) {
                context
                    .read<ChangePasswordForgotBloc>()
                    .add(RePasswordEvent(value));
              }),
            ],
          ),
        ),
        buildLogInAndRegButton(
            context, translate('change').toUpperCase(), "change", email),
        buildLogInAndRegButton(
            context, translate('exit').toUpperCase(), "back", email),
      ],
    ),
  );
}
