import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/email_verification/bloc/email_verification_blocs.dart';

import '../../common/widgets/flutter_toast.dart';
import 'bloc/email_verification_events.dart';

class EmailVerificationController {
  final BuildContext context;

  const EmailVerificationController({required this.context});

  Future<void> hanldeResendCode(String email) async {

  }

  Future<void> hanldeEmailVerification() async {
    try {
      final state = context.read<EmailVerificationBloc>().state;
      String code = state.code;
      if (code.isEmpty) {
        toastInfo(msg: "Bạn phải điền mã xác thực");
        return;
      }
    } catch (e) {}
    context.read<EmailVerificationBloc>().add(EmailVerificationResetEvent());
    Navigator.of(context).pushNamed("/alumniVerification");
  }
}