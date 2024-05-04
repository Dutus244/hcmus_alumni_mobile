import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/values/constants.dart';
import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
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
      if (!isValidEmail(email)) {
        toastInfo(msg: "Email không hợp lệ");
        return;
      }
      if (password.isEmpty) {
        toastInfo(msg: "Bạn phải điền mật khẩu");
        return;
      }
      if (rePassword.isEmpty) {
        toastInfo(msg: "Bạn phải điền nhập lại mật khẩu");
        return;
      }
      if (rePassword != password) {
        toastInfo(msg: "Mật khẩu không khớp");
        return;
      }
      Global.storageService.setString(AppConstants.STORAGE_USER_EMAIL, email);
      Global.storageService
          .setString(AppConstants.STORAGE_USER_PASSWORD, password);
      Navigator.of(context).pushNamed("/emailVerification");
    } catch (e) {}
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
