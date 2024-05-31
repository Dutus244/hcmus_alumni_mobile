import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../global.dart';
import 'package:http/http.dart' as http;

import 'bloc/event_detail_write_comment_blocs.dart';

class EventDetailWriteCommentController {
  final BuildContext context;

  const EventDetailWriteCommentController({required this.context});

  Future<void> handleLoadWriteComment(String id, int route) async {
    final state = context.read<EventDetailWriteCommentBloc>().state;
    String comment = state.comment;
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/events/$id/comments';
    var token = Global.storageService.getUserAuthToken();
    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };
    Map data = {'content': comment};
    var body = json.encode(data);
    try {
      var url = Uri.parse('$apiUrl$endpoint');
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/eventDetail",
          (route) => false,
          arguments: {
            "route": route,
            "id": id,
          },
        );
      } else {}
    } catch (error) {}
  }
}
