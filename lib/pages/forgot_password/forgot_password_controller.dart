import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../common/widgets/flutter_toast.dart';
import 'bloc/forgot_password_blocs.dart';
import 'bloc/forgot_password_events.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  ForgotPasswordController({required this.context});

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

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> handleEmailVerification() async {
    try {
      final state = context.read<ForgotPasswordBloc>().state;
      String email = state.email;
      if (email.isEmpty) {
        toastInfo(msg: translate('must_fill_email'));
        return;
      }
      if (!isValidEmail(email)) {
        toastInfo(msg: translate('invalid_email'));
        return;
      }
      context.read<ForgotPasswordBloc>().add(IsLoadingEvent(true));
      showLoadingIndicator();
      var url = Uri.parse('${dotenv.env['API_URL']}/auth/forgot-password');
      final map = <String, dynamic>{};
      map['email'] = email;

      try {
        var response = await http.post(url, body: map);
        if (response.statusCode == 200) {
          context.read<ForgotPasswordBloc>().add(IsLoadingEvent(false));
          hideLoadingIndicator();
          toastInfo(msg: 'Đã gửi mã thành công');
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/changePasswordForgot",
            (route) => false,
            arguments: {
              "email": email,
            },
          );
        } else {
          Map<String, dynamic> jsonMap = json.decode(response.body);
          int errorCode = jsonMap['error']['code'];
          context.read<ForgotPasswordBloc>().add(IsLoadingEvent(false));
          hideLoadingIndicator();
          if (errorCode == 10601) {
            toastInfo(msg: 'Email chưa tồn tại');
            return;
          }
          if (errorCode == 10602) {
            toastInfo(msg: translate('error_send_code'));
            return;
          }
        }
      } catch (error) {
        context.read<ForgotPasswordBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_send_code'));
      }
    } catch (e) {}
  }
}
