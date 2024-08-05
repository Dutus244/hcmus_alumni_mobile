import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'bloc/my_profile_add_achievement_blocs.dart';
import 'bloc/my_profile_add_achievement_events.dart';

class MyProfileAddAchievementController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  MyProfileAddAchievementController({required this.context});

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

  bool isValidDate(String dateString) {
    try {
      DateTime dateTime = DateFormat('dd/MM/yyyy').parse(dateString);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> handleAddAchievement() async {
    final state = context.read<MyProfileAddAchievementBloc>().state;
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/profile/achievement';
    var token = Global.storageService.getUserAuthToken();

    String time = "01/" + state.time;
    if (!isValidDate(time)) {
      toastInfo(msg: "Ngày nhập không hợp lệ");
      return;
    }
    context.read<MyProfileAddAchievementBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var body = json.encode({
      'achievementName': state.name,
      'achievementType': state.type,
      'achievementTime': time != ""
          ? DateFormat('yyyy-MM-dd')
              .format(DateFormat('dd/MM/yyyy').parse(time))
          : "",
      'privacy': 'PUBLIC',
    });

    try {
      // Send the request
      var response = await http.post(
        Uri.parse('$apiUrl$endpoint'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 201) {
        context.read<MyProfileAddAchievementBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: 'Thêm thành tựu thành công');
        Navigator.pop(context);
      } else {
        context.read<MyProfileAddAchievementBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_verify_alumni'));
      }
    } catch (e) {
      // Exception occurred
      // toastInfo(msg: translate('error_verify_alumni'));
      hideLoadingIndicator();
      print(e);
      return;
    }
  }

  Future<void> handleUpdateAchievement(String id) async {
    final state = context.read<MyProfileAddAchievementBloc>().state;
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/profile/achievement/$id';
    var token = Global.storageService.getUserAuthToken();

    String time = "01/" + state.time;
    if (!isValidDate(time)) {
      toastInfo(msg: "Ngày nhập không hợp lệ");
      return;
    }
    context.read<MyProfileAddAchievementBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var body = json.encode({
      'achievementName': state.name,
      'achievementType': state.type,
      'achievementTime': time != ""
          ? DateFormat('yyyy-MM-dd')
              .format(DateFormat('dd/MM/yyyy').parse(time))
          : "",
      'privacy': 'PUBLIC',
    });

    try {
      // Send the request
      var response = await http.put(
        Uri.parse('$apiUrl$endpoint'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        context.read<MyProfileAddAchievementBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: 'Chỉnh sửa thành tựu thành công');
        Navigator.pop(context);
      } else {
        context.read<MyProfileAddAchievementBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_verify_alumni'));
      }
    } catch (e) {
      // Exception occurred
      // toastInfo(msg: translate('error_verify_alumni'));
      hideLoadingIndicator();
      print(e);
      return;
    }
  }
}
