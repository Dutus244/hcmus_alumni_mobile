import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/fonts.dart';
import '../bloc/register_blocs.dart';
import '../bloc/register_events.dart';
import '../register_controller.dart';

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
              obscureText: textType == "email" ? false : true,
              maxLength: 50,
            ),
          )
        ],
      ));
}

Widget buildLogInAndRegButton(
    BuildContext context, String buttonName, String buttonType) {
  return GestureDetector(
    onTap: () {
      if (buttonType == "register") {
        RegisterController(context: context).handleRegister();
      } else {
        Navigator.of(context).pushNamed("/signIn");
      }
    },
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(
          left: 25.w, right: 25.w, top: buttonType == "register" ? 30.h : 20.h),
      decoration: BoxDecoration(
        color: buttonType == "register"
            ? AppColors.primaryElement
            : AppColors.primarySecondaryElement,
        borderRadius: BorderRadius.circular(15.w),
        border: Border.all(
          color: buttonType == "register"
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
              color: buttonType == "register"
                  ? AppColors.primaryBackground
                  : AppColors.primaryElement),
        ),
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
                      "ĐĂNG KÝ",
                      style: TextStyle(
                        fontFamily: AppFonts.Header0,
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp,
                      ),
                    ),
                  )),
              SizedBox(
                height: 5.h,
              ),
              buildTextField("Email *", "email", "email", (value) {
                context.read<RegisterBloc>().add(EmailEvent(value));
              }),
              SizedBox(
                height: 5.h,
              ),
              buildTextField("Mật khẩu *", "password", "lock",
                      (value) {
                    context
                        .read<RegisterBloc>()
                        .add(PasswordEvent(value));
                  }),
              SizedBox(
                height: 5.h,
              ),
              buildTextField(
                  "Nhập lại mật khẩu *", "rePassword", "lock",
                      (value) {
                    context
                        .read<RegisterBloc>()
                        .add(RePasswordEvent(value));
                  }),
            ],
          ),
        ),
        buildLogInAndRegButton(context, "ĐĂNG KÝ", "register"),
        buildLogInAndRegButton(context, "ĐĂNG NHẬP", "login"),
      ],
    ),
  );
}
