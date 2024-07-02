import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/services/firebase_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        String jwtToken = jsonMap['jwt'];

        var url =
            Uri.parse('${dotenv.env['API_URL']}/notification/subscription');
        final token = await FirebaseService().getFcmToken();
        var headers = <String, String>{
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json',
        };
        final body = jsonEncode({
          'token': token,
        });
        try {
          await http.post(url, body: body, headers: headers);
        } catch (error) {
          print(error);
        }

        Global.storageService.setString(AppConstants.USER_AUTH_TOKEN, jwtToken);
        if (rememberLogin) {
          Global.storageService.setBool(AppConstants.USER_REMEMBER_LOGIN, true);
          Global.storageService.setString(AppConstants.USER_EMAIL, email);
          Global.storageService.setString(AppConstants.USER_PASSWORD, password);
        }
        Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);
        Global.storageService.setString(
            AppConstants.USER_ID, decodedToken["sub"]);

        List<String> permissions = List<String>.from(jsonMap['permissions']);
        handleSavePermission(permissions);
        toastInfo(msg: translate('sign_in_success'));
        socketService.connect('0ac25d55-1ee6-4794-8d46-58f82cde644c');

        Navigator.of(context).pushNamedAndRemoveUntil(
            "/applicationPage", (route) => false, arguments: {"route": 0}
            );
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

        var url =
            Uri.parse('${dotenv.env['API_URL']}/notification/subscription');
        final token = await FirebaseService().getFcmToken();
        var headers = <String, String>{
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json',
        };
        final body = jsonEncode({
          'token': token,
        });
        try {
          await http.post(url, body: body, headers: headers);
        } catch (error) {
          print(error);
        }

        Global.storageService.setString(AppConstants.USER_AUTH_TOKEN, jwtToken);
        Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);
        Global.storageService.setString(
            AppConstants.USER_ID, decodedToken["sub"]);
        List<String> permissions = List<String>.from(jsonMap['permissions']);
        handleSavePermission(permissions);
        toastInfo(msg: translate('sign_in_success'));
        print(Global.storageService.getUserId());
        socketService.connect('0ac25d55-1ee6-4794-8d46-58f82cde644c');

        Navigator.of(context).pushNamedAndRemoveUntil(
            "/applicationPage", (route) => false, arguments: {"route": 0}
            );
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
