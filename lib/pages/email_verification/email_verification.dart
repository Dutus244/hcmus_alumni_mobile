import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/email_verification/bloc/email_verification_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/email_verification/bloc/email_verification_events.dart';
import 'package:hcmus_alumni_mobile/pages/email_verification/bloc/email_verification_states.dart';
import 'package:hcmus_alumni_mobile/pages/email_verification/email_verification_controller.dart';
import 'package:hcmus_alumni_mobile/pages/email_verification/widgets/email_verification_widget.dart';

import '../../common/values/colors.dart';

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
    EmailVerificationController(context: context).startResendCooldown();;
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
            body: emailVerification(context),
          )),
        );
      }),
    );
  }
}
