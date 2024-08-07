import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/services/firebase_service.dart';
import 'package:hcmus_alumni_mobile/pages/sign_in/bloc/sign_in_events.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../common/function/handle_save_permission.dart';
import '../../common/services/socket_service.dart';
import '../../common/values/constants.dart';
import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/user.dart';
import 'bloc/sign_in_blocs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignInController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  SignInController({required this.context});

  void showLoadingIndicator() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).size.height * 0.5 - 30,
        left: MediaQuery.of(context).size.width * 0.5 - 30,
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void hideLoadingIndicator() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

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
    context.read<SignInBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
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
        final token = await NotificationServices().getDeviceToken();
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
        Global.storageService.setString(AppConstants.USER_EMAIL, email);
        Global.storageService.setString(AppConstants.USER_PASSWORD, password);
        if (rememberLogin) {
          Global.storageService.setBool(AppConstants.USER_REMEMBER_LOGIN, true);
        }
        Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);
        Global.storageService
            .setString(AppConstants.USER_ID, decodedToken["sub"]);

        List<String> permissions = List<String>.from(jsonMap['permissions']);
        handleSavePermission(permissions);
        socketService.connect(Global.storageService.getUserId());

        url = Uri.parse(
            '${dotenv.env['API_URL']}/user/${Global.storageService.getUserId()}/profile');
        try {
          var response = await http.get(url, headers: headers);
          var responseBody = utf8.decode(response.bodyBytes);
          if (response.statusCode == 200) {
            var jsonMap = json.decode(responseBody);
            var user = User.fromJson(jsonMap["user"]);
            Global.storageService
                .setString(AppConstants.USER_FULL_NAME, user.fullName);
            Global.storageService
                .setString(AppConstants.USER_AVATAR_URL, user.avatarUrl);
          }
        } catch (error) {
          print(error);
        }
        context.read<SignInBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('sign_in_success'));
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/applicationPage", (route) => false,
            arguments: {"route": 0});
      } else {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        int errorCode = jsonMap['error']['code'];
        context.read<SignInBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        if (errorCode == 10100) {
          toastInfo(msg: 'Tài khoản đã bị khoá hoặc xoá');
          return;
        }
        if (errorCode == 10101) {
          toastInfo(msg: translate('email_password_invalid'));
          return;
        }
        if (errorCode == 10102) {
          toastInfo(msg: translate('email_password_invalid'));
          return;
        }
      }
    } catch (error) {
      context.read<SignInBloc>().add(IsLoadingEvent(false));
      hideLoadingIndicator();
      toastInfo(msg: translate('error_login'));
    }
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
