import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/forgot_password/bloc/forgot_password_events.dart';
import 'package:hcmus_alumni_mobile/pages/forgot_password/forgot_password_controller.dart';
import 'package:hcmus_alumni_mobile/pages/forgot_password/widgets/forgot_password_widget.dart';

import '../../common/values/colors.dart';
import '../../common/values/fonts.dart';
import 'bloc/forgot_password_blocs.dart';
import 'bloc/forgot_password_states.dart';
import 'dart:io';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  void initState() {
    super.initState();
    context.read<ForgotPasswordBloc>().add(ForgotPasswordResetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        Navigator.of(context).pushNamed("/signIn");
      },
      child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
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
                          padding: EdgeInsets.only(bottom: 5.h),
                          child: Text(
                            "QUÊN MẬT KHẨU",
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
                        buildTextFieldEmail("Email *", "email", "send",
                            (value) {
                          context
                              .read<ForgotPasswordBloc>()
                              .add(EmailEvent(value));
                        }, () {
                          ForgotPasswordController(context: context)
                              .hanldeResendCode();
                        }),
                        SizedBox(
                          height: 5.h,
                        ),
                        buildTextField("Mã xác thực *", "code", "", (value) {
                          context
                              .read<ForgotPasswordBloc>()
                              .add(CodeEvent(value));
                        }),
                      ],
                    ),
                  ),
                  buildVerifyAndBackButton("XÁC THỰC", "verify", () {
                    ForgotPasswordController(context: context)
                        .hanldeEmailVerification();
                  }),
                  buildVerifyAndBackButton("TRỞ VỀ", "back", () {
                    Navigator.of(context).pushNamed("/signIn");
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
