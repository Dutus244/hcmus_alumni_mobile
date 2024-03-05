import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/flutter_toast.dart';
import 'bloc/register_blocs.dart';

class RegisterController {
  final BuildContext context;

  const RegisterController({required this.context});

  Future<void> handleRegister(String type) async {
    try {
      if (type == "email") {
        final state = context.read<RegisterBloc>().state;
        String emailAddress = state.email;
        String password = state.password;
        String rePassword = state.rePassword;
        if (emailAddress.isEmpty) {
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
      }
    } catch (e) {}
  }
}