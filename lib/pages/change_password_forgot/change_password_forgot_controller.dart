import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../common/widgets/flutter_toast.dart';
import 'bloc/change_password_forgot_blocs.dart';
import 'bloc/change_password_forgot_events.dart';
import 'package:http/http.dart' as http;

class ChangePasswordForgotController {
  final BuildContext context;
  late Timer _timer;
  static bool isResending = false;
  int resendCooldown = 60;
  static int remainingTime = 0;
  OverlayEntry? _overlayEntry;

  ChangePasswordForgotController({required this.context});

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

  Future<void> handleResendCode(String email) async {
    if (isResending) {
      toastInfo(
          msg:
              "${translate('please_wait')} $remainingTime ${translate('seconds_resend_code').toLowerCase()}");
      return;
    }
    context.read<ChangePasswordForgotBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();

    var url = Uri.parse('${dotenv.env['API_URL']}/auth/forgot-password');
    final map = <String, dynamic>{};
    map['email'] = email;

    try {
      var response = await http.post(url, body: map);
      if (response.statusCode != 200) {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        int errorCode = jsonMap['error']['code'];
        context.read<ChangePasswordForgotBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        if (errorCode == 10601) {
          toastInfo(msg: 'Email chưa tồn tại');
          return;
        }
        if (errorCode == 10602) {
          toastInfo(msg: translate('error_send_code'));
          return;
        }
      } else {
        context.read<ChangePasswordForgotBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: 'Đã gửi mã thành công');
      }
      startResendCooldown();
    } catch (error) {
      context.read<ChangePasswordForgotBloc>().add(IsLoadingEvent(false));
      hideLoadingIndicator();
      toastInfo(msg: translate('error_send_code'));
    }
  }

  void startResendCooldown() {
    isResending = true;
    remainingTime = resendCooldown;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
      } else {
        isResending = false;
        _timer.cancel();
      }
    });
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

  Future<void> handleChangePassword(String email) async {
    try {
      final state = context.read<ChangePasswordForgotBloc>().state;
      String code = state.code;
      String password = state.password;
      String rePassword = state.rePassword;
      if (code.isEmpty) {
        toastInfo(msg: translate('must_fill_authentication_code'));
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
      context.read<ChangePasswordForgotBloc>().add(IsLoadingEvent(true));
      showLoadingIndicator();
      var url = Uri.parse('${dotenv.env['API_URL']}/auth/verify-reset-code');
      final map = <String, dynamic>{};
      map['email'] = email;
      map['resetCode'] = code;
      map['newPassword'] = password;

      try {
        var response = await http.post(url, body: map);
        if (response.statusCode == 200) {
          context.read<ChangePasswordForgotBloc>().add(IsLoadingEvent(false));
          hideLoadingIndicator();
          toastInfo(msg: 'Đã đổi password thành công');
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/signIn", (route) => false);
        } else {
          Map<String, dynamic> jsonMap = json.decode(response.body);
          int errorCode = jsonMap['error']['code'];
          context.read<ChangePasswordForgotBloc>().add(IsLoadingEvent(false));
          hideLoadingIndicator();
          if (errorCode == 10703) {
            toastInfo(msg: 'Email chưa tồn tại');
            return;
          }
          if (errorCode == 10704) {
            toastInfo(msg: 'Mã xác thực không hợp lệ hoặc đã hết hạn');
            return;
          }
        }
      } catch (error) {
        context.read<ChangePasswordForgotBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_verify_authentication_code'));
      }
    } catch (e) {}
  }
}
