import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcmus_alumni_mobile/pages/alumni_verification/bloc/alumni_verification_blocs.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../global.dart';

class AlumniVerificationController {
  final BuildContext context;

  const AlumniVerificationController({required this.context});

  Future<void> hanldeAlumniVerification(String fullName, File? avatar) async {
    try {
      final state = context.read<AlumniVerificationBloc>().state;
      String socialMediaLink = state.socialMediaLink;
      String studentId = state.studentId;
      String startYear = state.startYear.toString();


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
      request.fields['studentId'] = studentId;
      request.fields['beginningYear'] = startYear;
      request.fields['socialMediaLink'] = socialMediaLink;

      request.files.add(
        http.MultipartFile(
          'avatar',
          avatar!.readAsBytes().asStream(),
          avatar.lengthSync(),
          filename: avatar.toString(),
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      try {
        // Send the request
        var streamedResponse = await request.send();

        // Convert the streamed response to a regular HTTP response
        var response = await http.Response.fromStream(streamedResponse);
        if (response.statusCode == 201) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/applicationPage", (route) => false);
        } else {}
      } catch (e) {
        // Exception occurred
        print('Exception occurred: $e');
      }
    } catch (e) {}
  }
}
