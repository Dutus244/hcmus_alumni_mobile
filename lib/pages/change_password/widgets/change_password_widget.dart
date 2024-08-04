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

Widget buildTextField(BuildContext context, String hintText,
    String textType, String iconName, void Function(String value)? func) {
  return Container(
    width: 325.w,
    height: 40.h,
    margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
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
          width: 250.w,
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
            obscureText: !BlocProvider.of<ChangePasswordBloc>(context)
                .state
                .showPass,
            maxLength: 20,
          ),
        ),
        IconButton(
          icon: Icon(
            BlocProvider.of<ChangePasswordBloc>(context).state.showPass
                ? Icons.visibility
                : Icons.visibility_off,
            color: AppColors.primaryFourthElementText,
            size: 20.w,
          ),
          onPressed: () {
            context.read<ChangePasswordBloc>().add(ShowPassEvent(
                !BlocProvider.of<ChangePasswordBloc>(context)
                    .state
                    .showPass));
          },
        ),
      ],
    ),
  );
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
            buildTextField(context, translate('new_password*'), "password", 'lock', (value) {
              context
                  .read<ChangePasswordBloc>()
                  .add(PasswordEvent(value));
            }),
            SizedBox(
              height: 5.h,
            ),
            buildTextField(context, translate('re_new_password*'), "password",'lock',
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

Widget buttonChange(
    BuildContext context) {
  return Container(
    margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 30.h),
    height: 40.h,
    child: ElevatedButton(
      onPressed: () {
        if (!BlocProvider.of<ChangePasswordBloc>(context)
            .state
            .isLoading) {
          ChangePasswordController(context: context).handleChangePassword();
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.background,
        backgroundColor: AppColors.element,
        minimumSize: Size(325.w, 50.h),
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.w),
          side: BorderSide(color: Colors.transparent),
        ),
      ),
      child: Text(
        translate('save'),
        style: AppTextStyle.medium(context).wSemiBold().withColor(
            AppColors.background),
      ),
    ),
  );
}