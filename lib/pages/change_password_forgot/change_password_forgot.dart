import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/change_password_forgot/bloc/change_password_forgot_events.dart';

import '../../common/values/colors.dart';
import 'bloc/change_password_forgot_blocs.dart';
import 'bloc/change_password_forgot_states.dart';
import 'change_password_forgot_controller.dart';
import 'widgets/change_password_forgot_widget.dart';
import 'dart:io';

class ChangePasswordForgot extends StatefulWidget {
  const ChangePasswordForgot({super.key});

  @override
  State<ChangePasswordForgot> createState() => _ChangePasswordForgotState();
}

class _ChangePasswordForgotState extends State<ChangePasswordForgot> {
  @override
  void initState() {
    super.initState();

    context
        .read<ChangePasswordForgotBloc>()
        .add(ChangePasswordForgotResetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        Navigator.of(context).pushNamed("/forgotPassword");
      },
      child: BlocBuilder<ChangePasswordForgotBloc, ChangePasswordForgotState>(
          builder: (context, state) {
        return Container(
          color: AppColors.primaryBackground,
          child: SafeArea(
              child: Scaffold(
            backgroundColor: AppColors.primaryBackground,
            body: SingleChildScrollView(
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
                            "THAY ĐỔI MẬT KHẨU",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp,
                            ),
                          ),
                        )),
                        SizedBox(
                          height: 5.h,
                        ),
                        buildTextField("Mật khẩu mới *", "password", "lock",
                            (value) {
                          context
                              .read<ChangePasswordForgotBloc>()
                              .add(PasswordEvent(value));
                        }),
                        SizedBox(
                          height: 5.h,
                        ),
                        buildTextField(
                            "Nhập lại mật khẩu mới *", "password", "lock",
                            (value) {
                          context
                              .read<ChangePasswordForgotBloc>()
                              .add(RePasswordEvent(value));
                        }),
                      ],
                    ),
                  ),
                  buildLogInAndRegButton("THAY ĐỔI", "change", () {
                    ChangePasswordForgotController(context: context)
                        .hanldeChangePassword();
                  }),
                  buildLogInAndRegButton("THOÁT", "back", () {
                    Navigator.of(context).pushNamed("forgotPassword");
                  }),
                ],
              ),
            ),
          )),
        );
      }),
    );
  }
}
