import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcmus_alumni_mobile/pages/write_post_advise/bloc/write_post_advise_events.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'bloc/write_post_advise_blocs.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class WritePostAdviseController {
  final BuildContext context;

  const WritePostAdviseController({required this.context});

  List<Map<String, dynamic>> convertTagsToJson(List<String> tags) {
    return tags.map((tag) => {'id': tag}).toList();
  }

  Future<void> handlePost() async {
    final state = context.read<WritePostAdviseBloc>().state;
    String title = state.title;
    String content = state.content;
    List<String> tags = state.tags;
    List<File> pictures = state.pictures;

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    Map data = {
      'title': title,
      'content': content,
      'tags': convertTagsToJson(tags)
    };

    //encode Map to JSON
    var body = json.encode(data);

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.post(url, headers: headers, body: body);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 201) {
        var jsonMap = json.decode(responseBody);
        String id = jsonMap["id"];
        var endpoint =
            '/counsel/$id/images'; // Thay YOUR_API_URL bằng URL của API của bạn

        var headers = <String, String>{
          'Authorization': 'Bearer $token',
          "Content-Type": "multipart/form-data"
        };

        var request =
            http.MultipartRequest('PUT', Uri.parse('$apiUrl$endpoint'));
        request.headers.addAll(headers);

        for (var i = 0; i < pictures.length; i++) {
          request.files.add(
            http.MultipartFile(
              'addedImages',
              pictures[i].readAsBytes().asStream(),
              pictures[i].lengthSync(),
              filename: i.toString(),
              contentType: MediaType('image', 'jpeg'),
            ),
          );
        }

        try {
          // Send the request
          var response = await request.send();

          if (response.statusCode == 200) {
            context
                .read<WritePostAdviseBloc>()
                .add(WritePostAdviseResetEvent());
            Navigator.of(context).pushNamedAndRemoveUntil(
              "/applicationPage",
              (route) => false,
              arguments: {
                "route": 2,
                "secondRoute": 0,
              },
            );
          } else {}
        } catch (e) {
          // Exception occurred
          print('Exception occurred: $e');
        }
      } else {
        // Handle other status codes if needed
      }
    } catch (error, stacktrace) {
      // Handle errors
    }
  }
}