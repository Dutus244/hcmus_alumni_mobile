import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../common/values/constants.dart';
import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'bloc/register_blocs.dart';
import 'bloc/register_events.dart';
import 'package:http/http.dart' as http;

class RegisterController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  RegisterController({required this.context});

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

  bool isPasswordStrong(String password) {
    // Độ dài tối thiểu của mật khẩu
    final minLength = 8;

    // Kiểm tra độ dài của mật khẩu
    if (password.length < minLength) {
      return false;
    }

    // Kiểm tra sự kết hợp của các ký tự
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
    final hasDigits = RegExp(r'\d').hasMatch(password);
    final hasSpecialCharacters =
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

    // Kiểm tra nếu mật khẩu chứa ít nhất một ký tự viết hoa, một ký tự viết thường, một số và một ký tự đặc biệt
    return hasUppercase && hasLowercase && hasDigits && hasSpecialCharacters;
  }

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
      if (!isPasswordStrong(password)) {
        toastInfo(
            msg:
                'Mật khẩu ít nhất 8 ký tự và phải chứa ít nhất một ký tự viết hoa, một ký tự viết thường, một số và một ký tự đặc biệt');
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
      context.read<RegisterBloc>().add(IsLoadingEvent(true));
      showLoadingIndicator();
      var url = Uri.parse('${dotenv.env['API_URL']}/auth/send-authorize-code');
      final map = <String, dynamic>{};
      map['email'] = email;

      try {
        var response = await http.post(url, body: map);
        if (response.statusCode == 200) {
          Global.storageService.setString(AppConstants.USER_EMAIL, email);
          Global.storageService.setString(AppConstants.USER_PASSWORD, password);
          context.read<RegisterBloc>().add(IsLoadingEvent(false));
          hideLoadingIndicator();
          toastInfo(msg: 'Đã gửi mã thành công');
          Navigator.of(context).pushNamed("/emailVerification");
        } else {
          Map<String, dynamic> jsonMap = json.decode(response.body);
          int errorCode = jsonMap['error']['code'];
          context.read<RegisterBloc>().add(IsLoadingEvent(false));
          hideLoadingIndicator();
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
