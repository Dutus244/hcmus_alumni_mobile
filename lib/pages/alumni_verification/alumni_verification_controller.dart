import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_verification/bloc/alumni_verification_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_verification/bloc/alumni_verification_events.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../common/values/constants.dart';
import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/user.dart';

class AlumniVerificationController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  AlumniVerificationController({required this.context});

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

  Future<void> handleAlumniVerification(String fullName, File? avatar) async {
    context.read<AlumniVerificationBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
    final state = context.read<AlumniVerificationBloc>().state;
    String socialMediaLink = state.socialMediaLink;
    String studentId = state.studentId;
    String startYear = state.startYear.toString();
    String facultyId = state.facultyId.toString();

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/alumni-verification';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var request = http.MultipartRequest('POST', Uri.parse('$apiUrl$endpoint'));
    request.headers.addAll(headers);
    request.fields['fullName'] = fullName;
    request.fields['facultyId'] = facultyId;
    request.fields['studentId'] = studentId;
    request.fields['beginningYear'] = startYear;
    request.fields['socialMediaLink'] = socialMediaLink;

    if (avatar != null) {
      request.files.add(
        http.MultipartFile(
          'avatar',
          avatar!.readAsBytes().asStream(),
          avatar.lengthSync(),
          filename: avatar.toString(),
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    }

    try {
      // Send the request
      var streamedResponse = await request.send();

      // Convert the streamed response to a regular HTTP response
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 201) {
        context.read<AlumniVerificationBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: 'Đã nộp đơn xét duyệt cựu sinh viên thành công');
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/applicationPage", arguments: {"route": 0}, (route) => false);
      } else {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        int errorCode = jsonMap['error']['code'];
        context.read<AlumniVerificationBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        if (errorCode == 20400) {
          toastInfo(msg: translate('user_not_exist'));
          return;
        }
        if (errorCode == 20401) {
          toastInfo(msg: translate('invalid_data'));
          return;
        }
        if (errorCode == 20402) {
          toastInfo(msg: translate('error_save_image'));
          return;
        }
      }
    } catch (e) {
      context.read<AlumniVerificationBloc>().add(IsLoadingEvent(false));
      hideLoadingIndicator();
      toastInfo(msg: translate('error_verify_alumni'));
      return;
    }
  }
}
