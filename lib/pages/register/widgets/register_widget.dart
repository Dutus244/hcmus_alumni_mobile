import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/text_style.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../bloc/register_blocs.dart';
import '../bloc/register_events.dart';
import '../register_controller.dart';

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
                hintStyle: AppTextStyle.small(context)
                    .withColor(AppColors.secondaryElementText),
                counterText: '',
              ),
              style: AppTextStyle.small(context),
              autocorrect: false,
              obscureText: textType == "email" ? false : true,
              maxLength: 50,
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
            obscureText: !BlocProvider.of<RegisterBloc>(context).state.showPass,
            maxLength: textType == "email" ? 50 : 20,
          ),
        ),
        IconButton(
          icon: Icon(
            BlocProvider.of<RegisterBloc>(context).state.showPass
                ? Icons.visibility
                : Icons.visibility_off,
            color: AppColors.primaryFourthElementText,
            size: 20.w,
          ),
          onPressed: () {
            context.read<RegisterBloc>().add(ShowPassEvent(
                !BlocProvider.of<RegisterBloc>(context).state.showPass));
          },
        ),
      ],
    ),
  );
}

Widget buildLogInAndRegButton(
    BuildContext context, String buttonName, String buttonType) {
  return Container(
    width: 325.w,
    height: 50.h,
    margin: EdgeInsets.only(
        left: 25.w, right: 25.w, top: buttonType == "register" ? 30.h : 20.h),
    child: ElevatedButton(
      onPressed: () {
        if (!BlocProvider.of<RegisterBloc>(context).state.isLoading) {
          if (buttonType == "register") {
            RegisterController(context: context).handleRegister();
          } else {
            Navigator.of(context).pushNamed("/signIn");
          }
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor:
            buttonType == "register" ? AppColors.background : AppColors.element,
        backgroundColor: buttonType == "register"
            ? AppColors.element
            : AppColors.elementLight,
        minimumSize: Size(325.w, 50.h),
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.w),
          side: buttonType == "register"
              ? BorderSide(color: Colors.transparent)
              : BorderSide(color: AppColors.primaryFourthElementText),
        ),
      ),
      child: Text(
        buttonName,
        style: AppTextStyle.medium(context).wSemiBold().withColor(
            buttonType == "register"
                ? AppColors.background
                : AppColors.element),
      ),
    ),
  );
}

Widget register(BuildContext context) {
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
                  translate('signup').toUpperCase(),
                  style: AppTextStyle.large(context).wSemiBold(),
                ),
              )),
              SizedBox(
                height: 5.h,
              ),
              buildTextField(context, translate('email*'), "email", "email",
                  (value) {
                context.read<RegisterBloc>().add(EmailEvent(value));
              }),
              SizedBox(
                height: 5.h,
              ),
              buildTextFieldPassword(
                  context, translate('password*'), "password", "lock", (value) {
                context.read<RegisterBloc>().add(PasswordEvent(value));
              }),
              SizedBox(
                height: 5.h,
              ),
              buildTextFieldPassword(
                  context, translate('re_password*'), "rePassword", "lock",
                  (value) {
                context.read<RegisterBloc>().add(RePasswordEvent(value));
              }),
            ],
          ),
        ),
        buildLogInAndRegButton(
            context, translate('signup').toUpperCase(), "register"),
        buildLogInAndRegButton(
            context, translate('signin').toUpperCase(), "login"),
      ],
    ),
  );
}
