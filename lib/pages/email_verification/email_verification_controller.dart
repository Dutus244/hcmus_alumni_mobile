import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcmus_alumni_mobile/pages/email_verification/bloc/email_verification_blocs.dart';

import '../../common/values/constants.dart';
import '../../common/widgets/flutter_toast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../../global.dart';
import 'dart:convert';

class EmailVerificationController {
  final BuildContext context;
  late Timer _timer;
  static bool isResending = false;
  int resendCooldown = 60;
  static int remainingTime = 0;

  EmailVerificationController({required this.context});

  Future<void> handleResendCode() async {
    final email = Global.storageService.getUserEmail();
    if (isResending) {
      toastInfo(msg: "Vui lòng đợi $remainingTime giây để gửi lại mã");
      return;
    }

    var url = Uri.parse('${dotenv.env['API_URL']}/auth/send-authorize-code');
    final map = <String, dynamic>{};
    map['email'] = email;

    try {
      var response = await http.post(url, body: map);
      isResending = true;
      startResendCooldown();
    } catch (error, stacktrace) {
      toastInfo(msg: "Có lỗi xảy ra khi gửi mã xác thực");
    }
  }

  void startResendCooldown() {
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

  Future<void> handleEmailVerification() async {
    final email = Global.storageService.getUserEmail();
    try {
      final state = context.read<EmailVerificationBloc>().state;
      String code = state.code;
      if (code.isEmpty) {
        toastInfo(msg: "Bạn phải điền mã xác thực");
        return;
      }
      var url =
          Uri.parse('${dotenv.env['API_URL']}/auth/verify-authorize-code');
      final map = <String, dynamic>{};
      map['email'] = email;
      map['activationCode'] = code;

      final password = Global.storageService.getUserPassword();

      try {
        var response = await http.post(url, body: map);

        if (response.statusCode == 200) {
          var url = Uri.parse('${dotenv.env['API_URL']}/auth/signup');
          final map = <String, dynamic>{};
          map['email'] = email;
          map['pass'] = password;

          try {
            var response = await http.post(url, body: map);
            if (response.statusCode == 201) {
              var url = Uri.parse('${dotenv.env['API_URL']}/auth/login');
              final map = <String, dynamic>{};
              map['email'] = email;
              map['pass'] = password;

              try {
                var response = await http.post(url, body: map);
                if (response.statusCode == 200) {
                  Map<String, dynamic> jsonMap = json.decode(response.body);
                  String jwtToken = jsonMap['jwt'];
                  Global.storageService.setString(
                      AppConstants.STORAGE_USER_AUTH_TOKEN, jwtToken);
                  Global.storageService
                      .setBool(AppConstants.STORAGE_USER_IS_LOGGED_IN, true);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      "/alumniInformation", (route) => false);
                } else {
                  // toastInfo(msg: "Email hoặc mật khẩu bị sai");
                }
              } catch (error, stacktrace) {
                toastInfo(msg: "Có lỗi xảy ra");
              }
            } else {
              // toastInfo(msg: "Email hoặc mật khẩu bị sai");
            }
          } catch (error, stacktrace) {
            toastInfo(msg: "Có lỗi xảy ra");
          }
        } else {
          toastInfo(msg: "Mã xác thực bị sai hoặc hết hạn");
        }
      } catch (error, stacktrace) {
        toastInfo(msg: "Có lỗi xảy ra khi xác minh mã xác thực");
      }
    } catch (e) {}
  }
}
