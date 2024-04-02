import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../common/values/constants.dart';
import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'bloc/sign_in_blocs.dart';
import 'package:http/http.dart' as http;

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  Future<void> handleSignIn() async {
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

    var url = Uri.parse('${dotenv.env['API_URL']}/auth/login');
    final map = <String, dynamic>{};
    map['email'] = email;
    map['pass'] = password;

    try {
      var response = await http.post(url, body: map);

      if (response.statusCode == 200) {
        Global.storageService
            .setString(AppConstants.STORAGE_USER_AUTH_TOKEN, response.body);
        Global.storageService
            .setBool(AppConstants.STORAGE_USER_IS_LOGGED_IN, true);
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/applicationPage", (route) => false);
      } else {
        toastInfo(msg: "Email hoặc mật khẩu bị sai");
      }
    } catch (error, stacktrace) {
      toastInfo(msg: "Có lỗi xảy ra");
    }
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
