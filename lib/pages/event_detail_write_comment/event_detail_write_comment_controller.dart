import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'package:http/http.dart' as http;

import 'bloc/event_detail_write_comment_blocs.dart';
import 'bloc/event_detail_write_comment_events.dart';

class EventDetailWriteCommentController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  EventDetailWriteCommentController({required this.context});

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

  Future<void> handleLoadWriteComment(String id) async {
    context.read<EventDetailWriteCommentBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
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
        context.read<EventDetailWriteCommentBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: 'Bình luận thành công');
        Navigator.pop(context);
      } else {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        int errorCode = jsonMap['error']['code'];
        context.read<EventDetailWriteCommentBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        if (errorCode == 51401) {
          toastInfo(msg: translate('no_post_found'));
          return;
        }
      }
    } catch (error) {
      // toastInfo(msg: translate('error_send_comment'));
      context.read<EventDetailWriteCommentBloc>().add(IsLoadingEvent(false));
      hideLoadingIndicator();
    }
  }
}
