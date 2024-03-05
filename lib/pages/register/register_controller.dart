import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/register/bloc/register_events.dart';

import '../../common/widgets/flutter_toast.dart';
import 'bloc/register_blocs.dart';

class RegisterController {
  final BuildContext context;

  const RegisterController({required this.context});

  Future<void> handleRegister() async {
    try {
      final state = context.read<RegisterBloc>().state;
      String email = state.email;
      String password = state.password;
      String rePassword = state.rePassword;
      if (email.isEmpty) {
        toastInfo(msg: "Bạn phải điền email");
        return;
      }
      if (password.isEmpty) {
        toastInfo(msg: "Bạn phải điền password");
        return;
      }
      if (rePassword.isEmpty) {
        toastInfo(msg: "Bạn phải điền password");
        return;
      }
      context.read<RegisterBloc>().add(RegisterResetEvent());
      Navigator.of(context).pushNamed("emailVerification", arguments: email);
    } catch (e) {}
  }
}
