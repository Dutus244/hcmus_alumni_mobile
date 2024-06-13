import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/widgets/flutter_toast.dart';
import 'bloc/change_password_blocs.dart';

class ChangePasswordController {
  final BuildContext context;

  const ChangePasswordController({required this.context});

  Future<void> hanldeChangePassword() async {
    try {
      final state = context.read<ChangePasswordBloc>().state;
      String password = state.password;
      String rePassword = state.rePassword;
      if (password.isEmpty) {
        toastInfo(msg: "Bạn phải điền mật khẩu mới");
        return;
      }
      if (rePassword.isEmpty) {
        toastInfo(msg: "Bạn phải điền nhập lại mật khẩu mới");
        return;
      }
      if (rePassword != password) {
        toastInfo(msg: "Mật khẩu không khớp");
        return;
      }
      Navigator.pop(context);
    } catch (e) {}
  }
}