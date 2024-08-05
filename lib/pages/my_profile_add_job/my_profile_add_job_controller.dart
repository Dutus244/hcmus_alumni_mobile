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
import 'bloc/my_profile_add_job_blocs.dart';
import 'bloc/my_profile_add_job_events.dart';

class MyProfileAddJobController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  MyProfileAddJobController({required this.context});

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
    print(dateString != "01/08/2023");
    try {
      DateTime dateTime = DateFormat('dd/MM/yyyy').parse(dateString);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> handleAddJob() async {
    final state = context.read<MyProfileAddJobBloc>().state;
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/profile/job';
    var token = Global.storageService.getUserAuthToken();

    String startTime = "01/" + state.startTime;
    if (!isValidDate(startTime)) {
      toastInfo(msg: "Ngày nhập không hợp lệ");
      return;
    }

    String endTime = state.endTime != "" ? ("01/" + state.endTime) : "";
    if (endTime != "" && !isValidDate(endTime)) {
      toastInfo(msg: "Ngày nhập không hợp lệ");
      return;
    }
    context.read<MyProfileAddJobBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var body = json.encode({
      'companyName': state.companyName,
      'position': state.position,
      'startTime': startTime != ""
          ? DateFormat('yyyy-MM-dd')
              .format(DateFormat('dd/MM/yyyy').parse(startTime))
          : "",
      'endTime': endTime != ""
          ? DateFormat('yyyy-MM-dd')
              .format(DateFormat('dd/MM/yyyy').parse(endTime))
          : "",
      'isWorking': state.isWorking,
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
        context.read<MyProfileAddJobBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: 'Thêm công việc thành công');
        Navigator.pop(context);
      } else {
        context.read<MyProfileAddJobBloc>().add(IsLoadingEvent(false));
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

  Future<void> handleUpdateJob(String id) async {
    final state = context.read<MyProfileAddJobBloc>().state;
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/profile/job/$id';
    var token = Global.storageService.getUserAuthToken();

    String startTime = "01/" + state.startTime;
    if (!isValidDate(startTime)) {
      toastInfo(msg: "Ngày nhập không hợp lệ");
      return;
    }

    String endTime = state.endTime != "" ? ("01/" + state.endTime) : "";
    if (endTime != "" && !isValidDate(endTime)) {
      toastInfo(msg: "Ngày nhập không hợp lệ");
      return;
    }
    context.read<MyProfileAddJobBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var body = json.encode({
      'companyName': state.companyName,
      'position': state.position,
      'startTime': startTime != ""
          ? DateFormat('yyyy-MM-dd')
              .format(DateFormat('dd/MM/yyyy').parse(startTime))
          : "",
      'endTime': endTime != ""
          ? DateFormat('yyyy-MM-dd')
              .format(DateFormat('dd/MM/yyyy').parse(endTime))
          : "",
      'isWorking': state.isWorking,
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
        context.read<MyProfileAddJobBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: 'Chỉnh sửa công việc thành công');
        Navigator.pop(context);
      } else {
        context.read<MyProfileAddJobBloc>().add(IsLoadingEvent(false));
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
