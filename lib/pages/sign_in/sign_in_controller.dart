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
      final state = context.read<SignInBloc>().state;
      String email = state.email;
      String password = state.password;
      if (email.isEmpty) {
        toastInfo(msg: "Bạn phải điền email");
        return;
      }
      if (password.isEmpty) {
        toastInfo(msg: "Bạn phải điền password");
        return;
      }
      context.read<SignInBloc>().add(SignInResetEvent());
    } catch (e) {}
  }
}
