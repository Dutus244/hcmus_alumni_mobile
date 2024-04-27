import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../global.dart';
import 'package:http/http.dart' as http;

import 'bloc/news_detail_write_children_comment_blocs.dart';

class NewsDetailWriteChildrenCommentController {
  final BuildContext context;

  const NewsDetailWriteChildrenCommentController({required this.context});

  Future<void> handleLoadWriteComment(String id, String commentId) async {
    final state = context.read<NewsDetailWriteChildrenCommentBloc>().state;
    String comment = state.comment;

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/news/$id/comments';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    Map data = {'parentId': commentId, 'content': comment};
    var body = json.encode(data);

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/newsDetail",
          (route) => false,
          arguments: {
            "route": 1,
            "id": id,
          },
        );
      } else {
        // Handle other status codes if needed
      }
    } catch (error, stacktrace) {
      // Handle errors
    }
  }
}
