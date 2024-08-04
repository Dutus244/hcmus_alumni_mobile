import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/constants.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'bloc/change_password_blocs.dart';
import 'bloc/change_password_events.dart';
import 'package:http/http.dart' as http;

class ChangePasswordController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  ChangePasswordController({required this.context});

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

  Future<void> handleChangePassword() async {
    try {
      final state = context.read<ChangePasswordBloc>().state;
      String password = state.password;
      String rePassword = state.rePassword;
      if (password.isEmpty) {
        toastInfo(msg: translate('must_fill_new_password'));
        return;
      }
      if (!isPasswordStrong(password)) {
        toastInfo(
            msg:
            'Mật khẩu ít nhất 8 ký tự và phải chứa ít nhất một ký tự viết hoa, một ký tự viết thường, một số và một ký tự đặc biệt');
        return;
      }
      if (rePassword.isEmpty) {
        toastInfo(msg: translate('must_fill_renew_password'));
        return;
      }
      if (rePassword != password) {
        toastInfo(msg: translate('2_password_not_match'));
        return;
      }
      context.read<ChangePasswordBloc>().add(IsLoadingEvent(true));
      showLoadingIndicator();
      var apiUrl = dotenv.env['API_URL'];
      var endpoint = '/auth/reset-password';
      var token = Global.storageService.getUserAuthToken();

      var headers = <String, String>{
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json" // Include bearer token in the headers
      };

      var body = json.encode({
        'email': Global.storageService.getUserEmail(),
        'oldPassword': Global.storageService.getUserPassword(),
        'newPassword': password
      });

      try {
        // Send the request
        var response = await http.post(
          Uri.parse('$apiUrl$endpoint'),
          headers: headers,
          body: body,
        );
        if (response.statusCode == 200) {
          Global.storageService.setString(AppConstants.USER_PASSWORD, password);
          context.read<ChangePasswordBloc>().add(IsLoadingEvent(false));
          hideLoadingIndicator();
          toastInfo(msg: 'Đã đổi mật khẩu thành công');
        } else {
          context.read<ChangePasswordBloc>().add(IsLoadingEvent(false));
          hideLoadingIndicator();
          toastInfo(msg: translate('error_change_password'));
        }
      } catch (e) {
        // Exception occurred
        // toastInfo(msg: translate('error_change_password'));
        hideLoadingIndicator();
        print(e);
        return;
      }
      Navigator.pop(context);
    } catch (e) {}
  }
}