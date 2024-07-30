import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../common/widgets/flutter_toast.dart';
import 'bloc/forgot_password_blocs.dart';

class ForgotPasswordController {
  final BuildContext context;

  const ForgotPasswordController({required this.context});

  Future<void> handleResendCode() async {
    try {
      final state = context.read<ForgotPasswordBloc>().state;
      String email = state.email;
      if (email.isEmpty) {
        toastInfo(msg: translate('must_fill_email'));
        return;
      }
    } catch (e) {}
  }

  Future<void> handleEmailVerification() async {
    try {
      final state = context.read<ForgotPasswordBloc>().state;
      String code = state.code;
      if (code.isEmpty) {
        toastInfo(msg: translate('must_fill_authentication_code'));
        return;
      }
      Navigator.of(context).pushNamed("/changePasswordForgot");
    } catch (e) {}
  }
}
