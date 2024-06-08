import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../common/values/constants.dart';
import '../../common/values/permissions.dart';
import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'bloc/sign_in_blocs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignInController {
  final BuildContext context;

  const SignInController({required this.context});

  bool hasPermission(List<String> permissions, String permissionToCheck) {
    return permissions.contains(permissionToCheck);
  }

  Future<void> handleSavePermission(List<String> permissions) async {
    if (hasPermission(permissions, Permissions.NEWS_COMMENT_CREATE)) {
      Global.storageService.setBool(Permissions.NEWS_COMMENT_CREATE, true);
    }

    if (hasPermission(permissions, Permissions.EVENT_COMMENT_CREATE)) {
      Global.storageService.setBool(Permissions.EVENT_COMMENT_CREATE, true);
    }

    if (hasPermission(permissions, Permissions.EVENT_PARTICIPANT_CREATE)) {
      Global.storageService.setBool(Permissions.EVENT_PARTICIPANT_CREATE, true);
    }

    if (hasPermission(permissions, Permissions.COUNSEL_CREATE)) {
      Global.storageService.setBool(Permissions.COUNSEL_CREATE, true);
    }

    if (hasPermission(permissions, Permissions.COUNSEL_REACTION_CREATE)) {
      Global.storageService.setBool(Permissions.COUNSEL_REACTION_CREATE, true);
    }

    if (hasPermission(permissions, Permissions.COUNSEL_COMMENT_CREATE)) {
      Global.storageService.setBool(Permissions.COUNSEL_COMMENT_CREATE, true);
    }

    if (hasPermission(permissions, Permissions.COUNSEL_VOTE)) {
      Global.storageService.setBool(Permissions.COUNSEL_VOTE, true);
    }

    if (hasPermission(permissions, Permissions.GROUP_CREATE)) {
      Global.storageService.setBool(Permissions.GROUP_CREATE, true);
    }

    if (hasPermission(permissions, Permissions.PROFILE_EDIT)) {
      Global.storageService.setBool(Permissions.PROFILE_EDIT, true);
    }

    if (hasPermission(permissions, Permissions.MESSAGE_CREATE)) {
      Global.storageService.setBool(Permissions.MESSAGE_CREATE, true);
    }
  }

  Future<void> handleSignIn() async {
    final state = context.read<SignInBloc>().state;
    String email = state.email;
    String password = state.password;
    bool rememberLogin = state.rememberLogin;
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
        Map<String, dynamic> jsonMap = json.decode(response.body);
        String jwtToken = jsonMap['jwt'];
        Global.storageService
            .setString(AppConstants.STORAGE_USER_AUTH_TOKEN, jwtToken);
        Global.storageService
            .setBool(AppConstants.STORAGE_USER_IS_LOGGED_IN, true);
        if (rememberLogin) {
          Global.storageService
              .setBool(AppConstants.STORAGE_USER_REMEMBER_LOGIN, true);
          Global.storageService
              .setString(AppConstants.STORAGE_USER_EMAIL, email);
          Global.storageService
              .setString(AppConstants.STORAGE_USER_PASSWORD, password);
        }

        List<String> permissions = List<String>.from(jsonMap['permissions']);
        handleSavePermission(permissions);
        toastInfo(msg: "Đăng nhập thành công");
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/applicationPage", (route) => false);
      } else {
        toastInfo(msg: "Email hoặc mật khẩu bị sai");
      }
    } catch (error) {
      toastInfo(msg: "Có lỗi xảy ra");
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
            .setString(AppConstants.STORAGE_USER_AUTH_TOKEN, jwtToken);
        Global.storageService
            .setBool(AppConstants.STORAGE_USER_IS_LOGGED_IN, true);
        List<String> permissions = List<String>.from(jsonMap['permissions']);
        handleSavePermission(permissions);
        toastInfo(msg: "Đăng nhập thành công");
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/applicationPage", (route) => false);
      } else {
        toastInfo(msg: "Email hoặc mật khẩu bị sai");
      }
    } catch (error) {
      toastInfo(msg: "Có lỗi xảy ra");
    }
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
