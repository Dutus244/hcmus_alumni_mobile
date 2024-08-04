import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/change_password_forgot/bloc/change_password_forgot_events.dart';
import 'package:hcmus_alumni_mobile/pages/change_password_forgot/change_password_forgot_controller.dart';

import '../../common/values/colors.dart';
import 'bloc/change_password_forgot_blocs.dart';
import 'bloc/change_password_forgot_states.dart';
import 'widgets/change_password_forgot_widget.dart';

class ChangePasswordForgot extends StatefulWidget {
  const ChangePasswordForgot({super.key});

  @override
  State<ChangePasswordForgot> createState() => _ChangePasswordForgotState();
}

class _ChangePasswordForgotState extends State<ChangePasswordForgot> {
  String email = "";

  @override
  void initState() {
    super.initState();
    ChangePasswordForgotController(context: context).startResendCooldown();
    context
        .read<ChangePasswordForgotBloc>()
        .add(ChangePasswordForgotResetEvent());
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      email = args["email"];
    }
    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        Navigator.of(context).pushNamed("/forgotPassword");
      },
      child: BlocBuilder<ChangePasswordForgotBloc, ChangePasswordForgotState>(
          builder: (context, state) {
        return Container(
          color: AppColors.background,
          child: SafeArea(
              child: Scaffold(
            backgroundColor: AppColors.background,
            body: changePassword(context, email),
          )),
        );
      }),
    );
  }
}
