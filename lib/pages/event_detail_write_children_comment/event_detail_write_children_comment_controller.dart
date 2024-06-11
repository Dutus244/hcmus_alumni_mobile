import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'package:http/http.dart' as http;

import 'bloc/event_detail_write_children_comment_blocs.dart';

class EventDetailWriteChildrenCommentController {
  final BuildContext context;

  const EventDetailWriteChildrenCommentController({required this.context});

  Future<void> handleLoadWriteComment(
      String id, String commentId, int route, int profile) async {
    final state = context.read<EventDetailWriteChildrenCommentBloc>().state;
    String comment = state.comment;

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/events/$id/comments';

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
          "/eventDetail",
          (route) => false,
          arguments: {
            "route": route,
            "id": id,
            "profile": profile,
          },
        );
      } else {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        int errorCode = jsonMap['error']['code'];
        if (errorCode == 51401) {
          toastInfo(msg: "Không tìm thấy bài viết");
          return;
        }
        if (errorCode == 51402) {
          toastInfo(msg: "Không tìm thấy bình luận cha");
          return;
        }
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: "Có lỗi xả ra khi gửi bình luận");
    }
  }
}
