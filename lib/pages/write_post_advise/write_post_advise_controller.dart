import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/pages/write_post_advise/bloc/write_post_advise_events.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'bloc/write_post_advise_blocs.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class WritePostAdviseController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  WritePostAdviseController({required this.context});

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

  List<Map<String, dynamic>> convertTagsToJson(List<String> tags) {
    return tags.map((tag) => {'name': tag}).toList();
  }

  List<Map<String, dynamic>> convertVoteToJson(List<String> vote) {
    return vote.map((vote) => {'name': vote}).toList();
  }

  Future<void> handlePost() async {
    final state = context.read<WritePostAdviseBloc>().state;
    String title = state.title;
    String content = state.content;
    List<String> tags = state.tags;
    List<String> vote = state.votes;
    List<File> pictures = state.pictures;
    bool allowMultipleVotes = state.allowMultipleVotes;
    bool allowAddOptions = state.allowAddOptions;

    if (vote.length > 0) {
      final shouldPost = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(translate('post_article')),
          content: Text(translate('post_article_vote_question')),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(translate('cancel')),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(translate('post')),
            ),
          ],
        ),
      );
      if (shouldPost != null && shouldPost) {
        context.read<WritePostAdviseBloc>().add(IsLoadingEvent(true));
        showLoadingIndicator();
        var apiUrl = dotenv.env['API_URL'];
        var endpoint = '/counsel';

        var token = Global.storageService.getUserAuthToken();

        var headers = <String, String>{
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json"
          // Include bearer token in the headers
        };

        Map data = {
          'title': title,
          'content': content,
          'tags': convertTagsToJson(tags),
          'votes': convertVoteToJson(vote),
          'allowMultipleVotes': allowMultipleVotes,
          'allowAddOptions': allowAddOptions,
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
                context.read<WritePostAdviseBloc>().add(IsLoadingEvent(false));
                hideLoadingIndicator();
                toastInfo(msg: "Đăng bài viết thành công");
                Navigator.pop(context);
              } else {
                context.read<WritePostAdviseBloc>().add(IsLoadingEvent(false));
                hideLoadingIndicator();
              }
            } catch (e) {
              // Exception occurred
              hideLoadingIndicator();
              print('Exception occurred: $e');
            }
          } else {
            Map<String, dynamic> jsonMap = json.decode(response.body);
            int errorCode = jsonMap['error']['code'];
            context.read<WritePostAdviseBloc>().add(IsLoadingEvent(false));
            hideLoadingIndicator();
            if (errorCode == 60302) {
              toastInfo(msg: "Số lượng thẻ không được vượt quá 5");
              return;
            }
            if (errorCode == 60303) {
              toastInfo(msg: "Số lượng lựa chọn không được vượt quá 10");
              return;
            }
          }
        } catch (error) {
          // Handle errors
          hideLoadingIndicator();
        }
      }
    } else {
      context.read<WritePostAdviseBloc>().add(IsLoadingEvent(true));
      showLoadingIndicator();
      var apiUrl = dotenv.env['API_URL'];
      var endpoint = '/counsel';

      var token = Global.storageService.getUserAuthToken();

      var headers = <String, String>{
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
        // Include bearer token in the headers
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
              context.read<WritePostAdviseBloc>().add(IsLoadingEvent(false));
              hideLoadingIndicator();
              toastInfo(msg: "Đăng bài viết thành công");
              Navigator.pop(context);
            } else {
              context.read<WritePostAdviseBloc>().add(IsLoadingEvent(false));
              hideLoadingIndicator();
            }
          } catch (e) {
            // Exception occurred
            hideLoadingIndicator();
          }
        } else {
          context.read<WritePostAdviseBloc>().add(IsLoadingEvent(false));
          hideLoadingIndicator();
          toastInfo(msg: translate('error_post_article'));
        }
      } catch (error) {
        hideLoadingIndicator();
      }
    }
  }
}
