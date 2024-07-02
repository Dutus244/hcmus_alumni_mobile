import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../common/services/socket_service.dart';
import '../../common/values/constants.dart';
import '../../global.dart';

class OptionPageController {
  final BuildContext context;

  const OptionPageController({required this.context});

  Future<void> handleSignOut() async {
    var token = Global.storageService.getUserAuthToken();
    var url =
    Uri.parse('${dotenv.env['API_URL']}/notification/subscription');
    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      await http.delete(url, headers: headers);
    } catch (error) {
      print(error);
    }
    Global.storageService.setString(AppConstants.USER_AUTH_TOKEN, '');
    Global.storageService
        .setBool(AppConstants.USER_REMEMBER_LOGIN, false);
    Global.storageService.setString(AppConstants.USER_EMAIL, '');
    Global.storageService.setString(AppConstants.USER_PASSWORD, '');
    socketService.disconnect();
    Navigator.of(context)
        .pushNamedAndRemoveUntil("/signIn", (route) => false);
  }
}