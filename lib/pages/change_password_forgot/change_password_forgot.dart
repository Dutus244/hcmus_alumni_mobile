import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/change_password_forgot/bloc/change_password_forgot_events.dart';

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
            body: changePassword(context),
          )),
        );
      }),
    );
  }
}
