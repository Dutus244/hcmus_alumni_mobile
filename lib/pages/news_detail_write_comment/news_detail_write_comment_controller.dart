import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'bloc/news_detail_write_comment_blocs.dart';
import 'package:http/http.dart' as http;

class NewsDetailWriteCommentController {
  final BuildContext context;

  const NewsDetailWriteCommentController({required this.context});

  Future<void> handleLoadWriteComment(String id, int route) async {
    final state = context.read<NewsDetailWriteCommentBloc>().state;
    String comment = state.comment;

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/news/$id/comments';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    Map data = {'content': comment};
    //encode Map to JSON
    var body = json.encode(data);

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/newsDetail",
          (route) => false,
          arguments: {
            "route": route,
            "id": id,
          },
        );
      } else {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        int errorCode = jsonMap['error']['code'];
        if (errorCode == 41201) {
          toastInfo(msg: "Không tìm thấy bài viết");
          return;
        }
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: "Có lỗi xả ra khi gửi bình luận");
    }
  }
}
