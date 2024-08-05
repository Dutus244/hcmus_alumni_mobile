import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'bloc/event_detail_edit_comment_blocs.dart';
import 'bloc/event_detail_edit_comment_events.dart';
import 'package:http/http.dart' as http;

class EventDetailEditCommentController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  EventDetailEditCommentController({required this.context});

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

  Future<void> handleEditComment(String id, String commentId) async {
    context.read<EventDetailEditCommentBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
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
        context.read<EventDetailEditCommentBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: 'Sủa bình luận thành công');
        Navigator.pop(context);
      } else {
        // Handle other status codes if needed
        context.read<EventDetailEditCommentBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_edit_comment'));
      }
    } catch (error) {
      // Handle errors
      // toastInfo(msg: translate('error_edit_comment'));
      hideLoadingIndicator();
    }
  }
}
