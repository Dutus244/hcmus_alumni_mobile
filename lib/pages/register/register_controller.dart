import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../common/values/constants.dart';
import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'bloc/register_blocs.dart';
import 'package:http/http.dart' as http;

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
        toastInfo(msg: translate('must_fill_email'));
        return;
      }
      if (!isValidEmail(email)) {
        toastInfo(msg: translate('invalid_email'));
        return;
      }
      if (password.isEmpty) {
        toastInfo(msg: translate('must_fill_password'));
        return;
      }
      if (rePassword.isEmpty) {
        toastInfo(msg: translate('must_fill_re_password'));
        return;
      }
      if (rePassword != password) {
        toastInfo(msg: translate('2_password_not_match'));
        return;
      }
      var url = Uri.parse('${dotenv.env['API_URL']}/auth/send-authorize-code');
      final map = <String, dynamic>{};
      map['email'] = email;

      try {
        var response = await http.post(url, body: map);
        print(response.body);
        if (response.statusCode == 200) {
          Global.storageService.setString(AppConstants.USER_EMAIL, email);
          Global.storageService
              .setString(AppConstants.USER_PASSWORD, password);
          Navigator.of(context).pushNamed("/emailVerification");
        }
        else {
          Map<String, dynamic> jsonMap = json.decode(response.body);
          int errorCode = jsonMap['error']['code'];
          if (errorCode == 10300) {
            toastInfo(msg: translate('email_already_exist'));
            return;
          }
          if (errorCode == 10302) {
            toastInfo(msg: translate('error_send_code'));
            return;
          }
        }
      } catch (error) {
        toastInfo(msg: translate('error_send_code'));
      }
    } catch (e) {
      toastInfo(msg: translate('error_send_code'));
    }
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
