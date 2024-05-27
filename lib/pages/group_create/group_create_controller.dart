import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcmus_alumni_mobile/pages/group_create/bloc/group_create_blocs.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'dart:io';

import '../../global.dart';

class GroupCreateController {
  final BuildContext context;

  const GroupCreateController({required this.context});

  Future<void> handleCreateGroup() async {
    final state = context.read<GroupCreateBloc>().state;
    String name = state.name;
    String description = state.description;
    String privacy = state.privacy == 0 ? 'PUBLIC' : 'PRIVATE';
    List<File> pictures = state.pictures;

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var request = http.MultipartRequest('POST', Uri.parse('$apiUrl$endpoint'));
    request.headers.addAll(headers);
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['privacy'] = privacy;

    for (var i = 0; i < pictures.length; i++) {
      request.files.add(
        http.MultipartFile(
          'cover',
          pictures[i].readAsBytes().asStream(),
          pictures[i].lengthSync(),
          filename: i.toString(),
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
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/applicationPage",
              (route) => false,
          arguments: {
            "route": 3,
            "secondRoute": 1,
          },
        );
      } else {}
    } catch (e) {
      // Exception occurred
      print('Exception occurred: $e');
    }
  }
}
