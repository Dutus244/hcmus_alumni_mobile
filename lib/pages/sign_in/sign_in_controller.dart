import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../common/function/handle_save_permission.dart';
import '../../common/services/socket_service.dart';
import '../../common/values/constants.dart';
import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'bloc/sign_in_blocs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  Future<void> handleSignIn() async {
    final state = context.read<SignInBloc>().state;
    String email = state.email;
    String password = state.password;
    bool rememberLogin = state.rememberLogin;
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

    var url = Uri.parse('${dotenv.env['API_URL']}/auth/login');
    final map = <String, dynamic>{};
    map['email'] = email;
    map['pass'] = password;

    try {
      var response = await http.post(url, body: map);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        String jwtToken = jsonMap['jwt'];
        Global.storageService
            .setString(AppConstants.USER_AUTH_TOKEN, jwtToken);
        if (rememberLogin) {
          Global.storageService
              .setBool(AppConstants.USER_REMEMBER_LOGIN, true);
          Global.storageService
              .setString(AppConstants.USER_EMAIL, email);
          Global.storageService
              .setString(AppConstants.USER_PASSWORD, password);
        }
        Global.storageService.setString(AppConstants.USER_ID, '0ac25d55-1ee6-4794-8d46-58f82cde644c');

        List<String> permissions = List<String>.from(jsonMap['permissions']);
        handleSavePermission(permissions);
        toastInfo(msg: translate('sign_in_success'));
        socketService.connect(Global.storageService.getUserId());

        Navigator.of(context).pushNamedAndRemoveUntil(
            "/applicationPage", (route) => false,
            arguments: {"route": 0});
      } else {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        int errorCode = jsonMap['error']['code'];
        if (errorCode == 10100) {
          toastInfo(msg: translate('email_password_invalid'));
          return;
        }
        if (errorCode == 10101) {
          toastInfo(msg: translate('email_password_invalid'));
          return;
        }
        if (errorCode == 10102) {
          toastInfo(msg: translate('error_login'));
          return;
        }
      }
    } catch (error) {
      toastInfo(msg: translate('error_login'));
    }
  }

  Future<void> handleRememberSignIn(String email, String password) async {
    var url = Uri.parse('${dotenv.env['API_URL']}/auth/login');
    final map = <String, dynamic>{};
    map['email'] = email;
    map['pass'] = password;

    try {
      var response = await http.post(url, body: map);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        String jwtToken = jsonMap['jwt'];
        Global.storageService
            .setString(AppConstants.USER_AUTH_TOKEN, jwtToken);
        Global.storageService.setString(AppConstants.USER_ID, '0ac25d55-1ee6-4794-8d46-58f82cde644c');
        List<String> permissions = List<String>.from(jsonMap['permissions']);
        handleSavePermission(permissions);
        toastInfo(msg: translate('sign_in_success'));
        socketService.connect(Global.storageService.getUserId());

        Navigator.of(context).pushNamedAndRemoveUntil(
            "/applicationPage", (route) => false,
            arguments: {"route": 0});
      } else {
        toastInfo(msg: translate('email_password_invalid'));
      }
    } catch (error) {
      toastInfo(msg: translate('error_login'));
    }
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
