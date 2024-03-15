import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/sign_in/bloc/sign_in_blocs.dart';

import '../../../common/values/colors.dart';

Widget buildTextField(String hintText, String textType, String iconName,
    void Function(String value)? func) {
  return Container(
      width: 325.w,
      height: 40.h,
      margin: textType == "email"
          ? EdgeInsets.only(bottom: 20.h)
          : EdgeInsets.only(bottom: 10.h),
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
            padding: EdgeInsets.only(top: 10.h),
            child: TextField(
              onChanged: (value) => func!(value),
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: hintText,
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
                color: AppColors.primaryText,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.normal,
                fontSize: 12.sp,
              ),
              autocorrect: false,
              obscureText: textType == "password" ? true : false,
              maxLength: 30,
            ),
          )
        ],
      ));
}

Widget forgotPassword(void Function()? func) {
  return Container(
    width: 100.w,
    height: 30.h,
    padding: EdgeInsets.only(left: 15.w),
    child: GestureDetector(
        onTap: func,
        child: Text(
          "Quên mật khẩu?",
          style: TextStyle(
            fontFamily: 'Roboto',
            color: AppColors.primaryText,
            decorationColor: AppColors.primaryText,
            decoration: TextDecoration.underline,
            fontSize: 10.sp,
          ),
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
            checkColor: AppColors.primaryBackground,
            fillColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return AppColors.primaryElement; // Selected color
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
            "Ghi nhớ đăng nhập",
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.black,
              decorationColor: Colors.black,
              decoration: TextDecoration.underline,
              fontSize: 10.sp,
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildLogInAndRegButton(
    String buttonName, String buttonType, void Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(
          left: 25.w, right: 25.w, top: buttonType == "login" ? 50.h : 20.h),
      decoration: BoxDecoration(
        color: buttonType == "login"
            ? AppColors.primaryElement
            : AppColors.primarySecondaryElement,
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
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: buttonType == "login"
                  ? AppColors.primaryBackground
                  : AppColors.primaryElement),
        ),
      ),
    ),
  );
}
