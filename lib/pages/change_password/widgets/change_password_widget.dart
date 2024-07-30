import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/assets.dart';
import 'package:hcmus_alumni_mobile/pages/change_password/change_password_controller.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/text_style.dart';
import '../bloc/change_password_blocs.dart';
import '../bloc/change_password_events.dart';
import 'dart:io';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.background,
    flexibleSpace: Center(
      child: Container(
        margin: Platform.isAndroid ? EdgeInsets.only(top: 20.h) : EdgeInsets.only(top: 40.h),
        child: Text(
          translate('change_password'),
          textAlign: TextAlign.center,
          style: AppTextStyle.medium(context).wSemiBold(),
        ),
      ),
    ),
  );
}

Widget buildTextField(BuildContext context, String hintText, String textType, String iconName,
    void Function(String value)? func) {
  return Container(
      width: 325.w,
      height: 40.h,
      margin: EdgeInsets.only(bottom: 20.h, left: 10.w, right: 10.w),
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
                hintStyle: AppTextStyle.small(context).withColor(AppColors.secondaryElementText),
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

Widget changePassword(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(height: 10.h,),
            buildTextField(context, translate('new_password*'), "password", AppAssets.lockIconP, (value) {
              context
                  .read<ChangePasswordBloc>()
                  .add(PasswordEvent(value));
            }),
            SizedBox(
              height: 5.h,
            ),
            buildTextField(context, translate('re_new_password*'), "password", AppAssets.lockIconP,
                    (value) {
                  context
                      .read<ChangePasswordBloc>()
                      .add(RePasswordEvent(value));
                }),
          ],
        ),),
      buttonChange(context)
    ],
  );
}

Widget buttonChange(BuildContext context) {
  String password = BlocProvider.of<ChangePasswordBloc>(context).state.password;
  String rePassword = BlocProvider.of<ChangePasswordBloc>(context).state.rePassword;
  return GestureDetector(
    onTap: () {
      if (password != "" && rePassword != "") {
        ChangePasswordController(context: context).handleChangePassword();
      }
    },
    child: Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 30.h),
      height: 30.h,
      decoration: BoxDecoration(
        color: (password != "" && rePassword != "")
            ? AppColors.element
            : AppColors.background,
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(
          color: AppColors.elementLight,
        ),
      ),
      child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 12.w, right: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  translate('save'),
                  style: AppTextStyle.base(context).wSemiBold().withColor((password != "" && rePassword != "")
                      ? AppColors.background
                      : Colors.black.withOpacity(0.3)),
                ),
                Container(
                  width: 6.w,
                ),
                SvgPicture.asset(
                  AppAssets.sendIconS,
                  width: 15.w,
                  height: 15.h,
                  color: (password != "" && rePassword != "")
                      ? AppColors.background
                      : Colors.black.withOpacity(0.5),
                ),
              ],
            ),
          )),
    ),
  );
}