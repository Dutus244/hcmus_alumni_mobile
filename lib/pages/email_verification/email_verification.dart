import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/email_verification/bloc/email_verification_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/email_verification/bloc/email_verification_events.dart';
import 'package:hcmus_alumni_mobile/pages/email_verification/bloc/email_verification_states.dart';
import 'package:hcmus_alumni_mobile/pages/email_verification/email_verification_controller.dart';
import 'package:hcmus_alumni_mobile/pages/email_verification/widgets/email_verification_widget.dart';

import '../../common/values/colors.dart';
import 'dart:io';

import '../../common/values/constants.dart';
import '../../global.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  void initState() {
    super.initState();
    context.read<EmailVerificationBloc>().add(EmailVerificationResetEvent());
    EmailVerificationController(context: context)
        .handleResendCode();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        Navigator.of(context).pushNamed("/register");
      },
      child: BlocBuilder<EmailVerificationBloc, EmailVerificationState>(
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
                            "XÁC THỰC NGƯỜI DÙNG",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp,
                            ),
                          ),
                        )),
                        Center(
                            child: Container(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Text(
                            "Mã xác thực đã được gửi đến ${Global.storageService.getUserEmail()}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: AppColors.primaryElement,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              fontSize: 11.sp,
                            ),
                          ),
                        )),
                        SizedBox(
                          height: 5.h,
                        ),
                        buildTextField("Mã xác thực  *", "code", "send",
                            (value) {
                          context
                              .read<EmailVerificationBloc>()
                              .add(CodeEvent(value));
                        }, () {
                          EmailVerificationController(context: context)
                              .handleResendCode();
                        }),
                      ],
                    ),
                  ),
                  buildVerifyAndBackButton("XÁC THỰC", "verify", () {
                    EmailVerificationController(context: context)
                        .handleEmailVerification();
                  }),
                  buildVerifyAndBackButton("TRỞ VỀ", "back", () {
                    Navigator.of(context).pushNamed("/register");
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