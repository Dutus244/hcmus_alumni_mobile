import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'bloc/event_detail_edit_comment_blocs.dart';
import 'package:http/http.dart' as http;

class EventDetailEditCommentController {
  final BuildContext context;

  const EventDetailEditCommentController({required this.context});

  Future<void> handleEditComment(String id, String commentId, int route, int profile) async {
    final state = context.read<EventDetailEditCommentBloc>().state;
    String comment = state.comment;

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/events/comments/$commentId';

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
          "/eventDetail",
              (route) => false,
          arguments: {
            "route": route,
            "id": id,
            "profile": profile,
          },
        );
      } else {
        // Handle other status codes if needed
        toastInfo(msg: "Có lỗi xả ra khi chỉnh sửa bình luận");
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: "Có lỗi xả ra khi chỉnh sửa bình luận");
    }
  }
}
