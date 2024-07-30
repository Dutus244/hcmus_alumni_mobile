import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/text_style.dart';
import 'package:hcmus_alumni_mobile/pages/sign_in/bloc/sign_in_blocs.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../sign_in_controller.dart';
import "../bloc/sign_in_events.dart";

Widget buildTextField(BuildContext context, String hintText, String textType, String iconName,
    void Function(String value)? func) {
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
                hintStyle: AppTextStyle.small(context).withColor(AppColors.secondaryElementText),
                counterText: '',
              ),
              style: AppTextStyle.small(context),
              autocorrect: false,
              obscureText: textType == "password" ? true : false,
              maxLength: 50,
            ),
          )
        ],
      ));
}

Widget forgotPassword(BuildContext context) {
  return Container(
    width: 100.w,
    height: 30.h,
    padding: EdgeInsets.only(left: 15.w),
    child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed("/forgotPassword");
        },
        child: Text(
          translate('forgot_password'),
          style: AppTextStyle.xSmall(context).underline(),
        )),
  );
}

Widget rememberLogin(BuildContext context, void Function(bool value)? func) {
  return Container(
    width: 135.w,
    height: 30.h,
    child: Row(
      children: [
        Container(
          width: 16.w,
          height: 16.w,
          margin: EdgeInsets.only(left: 0.w, right: 10.w),
          child: Checkbox(
            checkColor: AppColors.background,
            fillColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return AppColors.element; // Selected color
                }
                return Colors.transparent; // Unselected color
              },
            ),
            onChanged: (value) => func!(value!),
            value: BlocProvider.of<SignInBloc>(context).state.rememberLogin,
          ),
        ),
        Container(
          child: Text(
            translate('remember_login'),
            style: AppTextStyle.xSmall(context).underline(),
          ),
        )
      ],
    ),
  );
}

Widget buildLogInAndRegButton(
    BuildContext context, String buttonName, String buttonType) {
  return GestureDetector(
    onTap: () {
      if (buttonType == "login") {
        SignInController(context: context).handleSignIn();
      } else {
        Navigator.of(context).pushNamed("/register");
      }
    },
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(
          left: 25.w, right: 25.w, top: buttonType == "login" ? 50.h : 20.h),
      decoration: BoxDecoration(
        color: buttonType == "login"
            ? AppColors.element
            : AppColors.elementLight,
        borderRadius: BorderRadius.circular(15.w),
        border: Border.all(
          color: buttonType == "login"
              ? Colors.transparent
              : AppColors.primaryFourthElementText,
        ),
      ),
      child: Center(
        child: Text(
          buttonName,
          style: AppTextStyle.medium(context).wSemiBold().withColor(buttonType == "login"
              ? AppColors.background
              : AppColors.element),
        ),
      ),
    ),
  );
}

Widget signIn(BuildContext context) {
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
                    padding: EdgeInsets.only(bottom: 15.h),
                    child: Text(
                      translate('signin').toUpperCase(),
                      style: AppTextStyle.large(context).wSemiBold(),
                    ),
                  )),
              SizedBox(
                height: 5.h,
              ),
              buildTextField(context, translate('email*'), "email", "email", (value) {
                context.read<SignInBloc>().add(EmailEvent(value));
              }),
              SizedBox(
                height: 5.h,
              ),
              buildTextField(context, translate('password*'), "password", "lock",
                      (value) {
                    context.read<SignInBloc>().add(PasswordEvent(value));
                  }),
            ],
          ),
        ),
        Container(
          padding:
          EdgeInsets.only(left: 25.w, right: 25.w, top: 10.h),
          height: 24.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              rememberLogin(context, (value) {
                context
                    .read<SignInBloc>()
                    .add(RememberLoginEvent(value));
              }),
              forgotPassword(context),
            ],
          ),
        ),
        buildLogInAndRegButton(context, translate('signin').toUpperCase(), "login"),
        buildLogInAndRegButton(context, translate('signup').toUpperCase(), "register"),
      ],
    ),
  );
}
