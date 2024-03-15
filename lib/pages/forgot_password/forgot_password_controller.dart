import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/flutter_toast.dart';
import 'bloc/forgot_password_blocs.dart';
import 'bloc/forgot_password_events.dart';

class ForgotPasswordController {
  final BuildContext context;

  const ForgotPasswordController({required this.context});

  Future<void> hanldeResendCode() async {
    try {
      final state = context.read<ForgotPasswordBloc>().state;
      String email = state.email;
      if (email.isEmpty) {
        toastInfo(msg: "Bạn phải điền email");
        return;
      }
    } catch (e) {}
  }

  Future<void> hanldeEmailVerification() async {
    try {
      final state = context.read<ForgotPasswordBloc>().state;
      String code = state.code;
      if (code.isEmpty) {
        toastInfo(msg: "Bạn phải điền mã xác thực");
        return;
      }
      context.read<ForgotPasswordBloc>().add(ForgotPasswordResetEvent());
      Navigator.of(context).pushNamed("/changePasswordForgot");
    } catch (e) {}
  }
}