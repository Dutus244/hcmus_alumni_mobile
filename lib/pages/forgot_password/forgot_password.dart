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
            body: forgotPassword(context),
          )),
        );
      }),
    );
  }
}
