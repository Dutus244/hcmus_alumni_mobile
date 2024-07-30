import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/pages/email_verification/bloc/email_verification_blocs.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../common/function/handle_save_permission.dart';
import '../../common/services/firebase_service.dart';
import '../../common/services/socket_service.dart';
import '../../common/values/constants.dart';
import '../../common/widgets/flutter_toast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../../global.dart';
import 'dart:convert';

import '../../model/user.dart';

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
      toastInfo(msg: "${translate('please_wait')} $remainingTime ${translate('seconds_resend_code').toLowerCase()}");
      return;
    }

    var url = Uri.parse('${dotenv.env['API_URL']}/auth/send-authorize-code');
    final map = <String, dynamic>{};
    map['email'] = email;

    try {
      var response = await http.post(url, body: map);
      if (response.statusCode != 200) {
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
      startResendCooldown();
    } catch (error) {
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

  Future<void> handleEmailVerification() async {
    final email = Global.storageService.getUserEmail();
    try {
      final state = context.read<EmailVerificationBloc>().state;
      String code = state.code;
      if (code.isEmpty) {
        toastInfo(msg: translate('must_fill_authentication_code'));
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
            if (response.statusCode == 200) {
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
                      AppConstants.USER_AUTH_TOKEN, jwtToken);

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

                  Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);
                  Global.storageService
                      .setString(AppConstants.USER_ID, decodedToken["sub"]);

                  List<String> permissions = List<String>.from(jsonMap['permissions']);
                  handleSavePermission(permissions);
                  socketService.connect(Global.storageService.getUserId());

                  Navigator.of(context).pushNamedAndRemoveUntil(
                      "/alumniInformation", (route) => false);
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
                    toastInfo(msg: translate('error_sigin'));
                    return;
                  }
                }
              } catch (error) {
                print(error);
                toastInfo(msg: translate('error_login'));
              }
            } else {
              Map<String, dynamic> jsonMap = json.decode(response.body);
              int errorCode = jsonMap['error']['code'];
              if (errorCode == 10200) {
                toastInfo(msg: translate('email_password_invalid'));
                return;
              }
              if (errorCode == 10201) {
                toastInfo(msg: translate('email_password_invalid'));
                return;
              }
            }
          } catch (error) {
            print(error);
            toastInfo(msg: translate('error_register'));
          }
        } else {
          Map<String, dynamic> jsonMap = json.decode(response.body);
          int errorCode = jsonMap['error']['code'];
          if (errorCode == 10402) {
            toastInfo(msg: translate('authentication_code_invalid_expired'));
            return;
          }
          if (errorCode == 10403) {
            toastInfo(msg: translate('error_verify_authentication_code'));
            return;
          }
        }
      } catch (error) {
        toastInfo(msg: translate('error_verify_authentication_code'));
      }
    } catch (e) {
      toastInfo(msg: translate('error_verify_authentication_code'));
    }
  }
}
