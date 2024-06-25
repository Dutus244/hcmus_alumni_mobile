import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../common/widgets/flutter_toast.dart';
import 'bloc/change_password_blocs.dart';

class ChangePasswordController {
  final BuildContext context;

  const ChangePasswordController({required this.context});

  Future<void> handleChangePassword() async {
    try {
      final state = context.read<ChangePasswordBloc>().state;
      String password = state.password;
      String rePassword = state.rePassword;
      if (password.isEmpty) {
        toastInfo(msg: translate('must_fill_new_password'));
        return;
      }
      if (rePassword.isEmpty) {
        toastInfo(msg: translate('must_fill_renew_password'));
        return;
      }
      if (rePassword != password) {
        toastInfo(msg: translate('2_password_not_match'));
        return;
      }
      Navigator.pop(context);
    } catch (e) {}
  }
}