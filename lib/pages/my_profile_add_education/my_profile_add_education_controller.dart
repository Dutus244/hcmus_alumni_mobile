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
import 'bloc/my_profile_add_education_blocs.dart';
import 'bloc/my_profile_add_education_events.dart';

class MyProfileAddEducationController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  MyProfileAddEducationController({required this.context});

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

  Future<void> handleAddEducation() async {
    final state = context.read<MyProfileAddEducationBloc>().state;
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/profile/education';
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
    context.read<MyProfileAddEducationBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var body = json.encode({
      'schoolName': state.schoolName,
      'degree': state.degree,
      'startTime': startTime != ""
          ? DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy')
              .parse(startTime))
          : "",
      'endTime': endTime != ""
          ? DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy')
              .parse(endTime))
          : "",
      'isLearning': state.isStudying,
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
        context.read<MyProfileAddEducationBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: 'Thêm học vấn thành công');
        Navigator.pop(context);
      } else {
        context.read<MyProfileAddEducationBloc>().add(IsLoadingEvent(false));
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

  Future<void> handleUpdateEducation(String id) async {
    final state = context.read<MyProfileAddEducationBloc>().state;
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/profile/education/$id';
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
    context.read<MyProfileAddEducationBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var body = json.encode({
      'schoolName': state.schoolName,
      'degree': state.degree,
      'startTime': startTime != ""
          ? DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy')
              .parse(startTime)
              )
          : "",
      'endTime': endTime != ""
          ? DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy')
              .parse(endTime)
              )
          : "",
      'isLearning': state.isStudying,
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
        context.read<MyProfileAddEducationBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: 'Chỉnh sửa học vấn thành công');
        Navigator.pop(context);
      } else {
        context.read<MyProfileAddEducationBloc>().add(IsLoadingEvent(false));
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
