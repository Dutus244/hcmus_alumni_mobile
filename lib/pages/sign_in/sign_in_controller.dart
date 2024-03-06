import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/flutter_toast.dart';
import 'bloc/sign_in_blocs.dart';
import 'bloc/sign_in_events.dart';

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  Future<void> handleSignIn() async {
    try {
      if (type == "email") {
        // BlocProvider.of<SignInBloc>(context).state
      final state = context.read<SignInBloc>().state;
      String email = state.email;
      String password = state.password;
      if (email.isEmpty) {
        toastInfo(msg: "Bạn phải điền email");
        return;
      }
      if (!isValidEmail(email)) {
        toastInfo(msg: "Email không hợp lệ");
        return;
      }
      if (password.isEmpty) {
        toastInfo(msg: "Bạn phải điền mật khẩu");
        return;
      }
      context.read<SignInBloc>().add(SignInResetEvent());
      Navigator.of(context)
          .pushNamedAndRemoveUntil("landing", (route) => false);
    } catch (e) {}
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
