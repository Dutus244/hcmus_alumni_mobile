import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../global.dart';
import 'bloc/news_detail_edit_comment_blocs.dart';
import 'package:http/http.dart' as http;

class NewsDetailEditCommentController {
  final BuildContext context;

  const NewsDetailEditCommentController({required this.context});

  Future<void> handleEditComment(String id, String commentId, int route) async {
    final state = context.read<NewsDetailEditCommentBloc>().state;
    String comment = state.comment;

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/news/comments/$commentId';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    Map data = {'content': comment};
    var body = json.encode(data);

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/newsDetail",
              (route) => false,
          arguments: {
            "route": route,
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
