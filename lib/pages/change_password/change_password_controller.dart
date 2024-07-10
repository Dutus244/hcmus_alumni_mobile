import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/common/values/constants.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'bloc/change_password_blocs.dart';
import 'package:http/http.dart' as http;

class ChangePasswordController {
  final BuildContext context;

  const ChangePasswordController({required this.context});

  Future<void> handleChangePassword() async {
    try {
      final state = context.read<ChangePasswordBloc>().state;
      String password = state.password;
      String rePassword = state.rePassword;
      if (password.isEmpty) {
        toastInfo(msg: translate('must_fill_new_password'));
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
        } else {
          toastInfo(msg: translate('error_change_password'));
        }
      } catch (e) {
        // Exception occurred
        toastInfo(msg: translate('error_change_password'));
        print(e);
        return;
      }
      Navigator.pop(context);
    } catch (e) {}
  }
}