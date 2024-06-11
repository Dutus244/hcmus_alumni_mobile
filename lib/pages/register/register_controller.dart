import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
      var url = Uri.parse('${dotenv.env['API_URL']}/auth/send-authorize-code');
      final map = <String, dynamic>{};
      map['email'] = email;

      try {
        var response = await http.post(url, body: map);
        if (response.statusCode == 200) {
          Global.storageService.setString(AppConstants.STORAGE_USER_EMAIL, email);
          Global.storageService
              .setString(AppConstants.STORAGE_USER_PASSWORD, password);
          Navigator.of(context).pushNamed("/emailVerification");
        }
        else {
          Map<String, dynamic> jsonMap = json.decode(response.body);
          int errorCode = jsonMap['error']['code'];
          if (errorCode == 10300) {
            toastInfo(msg: "Email đã tồn tại");
            return;
          }
          if (errorCode == 10302) {
            toastInfo(msg: "Gửi mã xác thực thất bại");
            return;
          }
        }
      } catch (error) {
        toastInfo(msg: "Có lỗi xảy ra khi gửi mã xác thực");
      }
    } catch (e) {
      toastInfo(msg: "Có lỗi xảy ra khi gửi mã xác thực");
    }
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
