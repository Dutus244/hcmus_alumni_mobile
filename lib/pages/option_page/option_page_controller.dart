import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/pages/option_page/bloc/option_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/option_page/bloc/option_page_events.dart';
import 'package:http/http.dart' as http;

import '../../common/services/firebase_service.dart';
import '../../common/services/socket_service.dart';
import '../../common/values/constants.dart';
import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';

class OptionPageController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  OptionPageController({required this.context});

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

  Future<void> handleSignOut() async {
    context.read<OptionPageBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
    var token = Global.storageService.getUserAuthToken();
    var url =
    Uri.parse('${dotenv.env['API_URL']}/notification/subscription');
    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final notificationToken = await NotificationServices().getDeviceToken();
    final body = jsonEncode({
      'token': notificationToken,
    });
    try {
      var response = await http.delete(url, headers: headers, body: body);
      print(response.body);
    } catch (error) {
      print(error);
    }
    Global.storageService.setString(AppConstants.USER_AUTH_TOKEN, '');
    Global.storageService
        .setBool(AppConstants.USER_REMEMBER_LOGIN, false);
    Global.storageService.setString(AppConstants.USER_EMAIL, '');
    Global.storageService.setString(AppConstants.USER_PASSWORD, '');
    socketService.disconnect();
    context.read<OptionPageBloc>().add(IsLoadingEvent(false));
    hideLoadingIndicator();
    toastInfo(msg: 'Đăng xuất thành công');
    Navigator.of(context)
        .pushNamedAndRemoveUntil("/signIn", (route) => false);
  }

  Future<void> handleDeleteUser() async {
    final shouldDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Xoá tài khoản'),
        content: Text('Bạn có muốn xoá tài khoản của mình?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(translate('cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(translate('delete')),
          ),
        ],
      ),
    );
    if (shouldDelete != null && shouldDelete) {
      context.read<OptionPageBloc>().add(IsLoadingEvent(true));
      showLoadingIndicator();
      var token = Global.storageService.getUserAuthToken();
      var url =
      Uri.parse('${dotenv.env['API_URL']}/user/self');
      var headers = <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      try {
        var response = await http.delete(url, headers: headers);
        print(response.body);
      } catch (error) {
        print(error);
      }
      Global.storageService.setString(AppConstants.USER_AUTH_TOKEN, '');
      Global.storageService
          .setBool(AppConstants.USER_REMEMBER_LOGIN, false);
      Global.storageService.setString(AppConstants.USER_EMAIL, '');
      Global.storageService.setString(AppConstants.USER_PASSWORD, '');
      socketService.disconnect();
      context.read<OptionPageBloc>().add(IsLoadingEvent(false));
      hideLoadingIndicator();
      toastInfo(msg: 'Xoá tài khoản thành công');
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/signIn", (route) => false);
    }
  }
}