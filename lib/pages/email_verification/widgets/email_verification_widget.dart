import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';

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
            padding: EdgeInsets.only(top: 10.h, left: 17.w),
            child: TextField(
              onChanged: (value) => func1!(value),
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
                fontFamily: 'Roboto',
                color: AppColors.primaryText,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp,
              ),
              autocorrect: false,
              obscureText: textType == "password" ? true : false,
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
    String buttonName, String buttonType, void Function()? func) {
  return GestureDetector(
    onTap: func,
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(
          left: 25.w, right: 25.w, top: buttonType == "verify" ? 80.h : 20.h),
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
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ]),
      child: Center(
        child: Text(
          buttonName,
          style: TextStyle(
              fontFamily: 'Roboto',
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
