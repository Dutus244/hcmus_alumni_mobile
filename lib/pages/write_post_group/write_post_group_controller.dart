import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../global.dart';
import 'bloc/write_post_group_blocs.dart';
import 'bloc/write_post_group_events.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class WritePostGroupController {
  final BuildContext context;

  const WritePostGroupController({required this.context});

  List<Map<String, dynamic>> convertTagsToJson(List<String> tags) {
    return tags.map((tag) => {'name': tag}).toList();
  }

  List<Map<String, dynamic>> convertVoteToJson(List<String> vote) {
    return vote.map((vote) => {'name': vote}).toList();
  }

  Future<void> handlePost(String groupId, int secondRoute) async {
    final state = context.read<WritePostGroupBloc>().state;
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
        builder: (context) =>
            AlertDialog(
              title: Text('Đăng bài viết'),
              content: Text(
                  'Bài viết có bình chọn không thể sửa đổi sau khi đăng?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('Huỷ'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text('Đăng'),
                ),
              ],
            ),
      );
      if (shouldPost != null && shouldPost) {
        var apiUrl = dotenv.env['API_URL'];
        var endpoint = '/groups/$groupId/posts';

        var token = Global.storageService.getUserAuthToken();

        var headers = <String, String>{
          'Authorization': 'Bearer $token',
          "Content-Type": "application/json" // Include bearer token in the headers
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
                '/groups/posts/$id/images'; // Thay YOUR_API_URL bằng URL của API của bạn

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
                    .read<WritePostGroupBloc>()
                    .add(WritePostGroupResetEvent());
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/groupDetail",
                      (route) => false,
                  arguments: {
                    "id": groupId,
                    "secondRoute": secondRoute,
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
        } catch (error) {
          // Handle errors
        }
      }
    }
    else {
      var apiUrl = dotenv.env['API_URL'];
      var endpoint = '/groups/$groupId/posts';

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
              '/groups/posts/$id/images'; // Thay YOUR_API_URL bằng URL của API của bạn

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
                  .read<WritePostGroupBloc>()
                  .add(WritePostGroupResetEvent());
              Navigator.of(context).pushNamedAndRemoveUntil(
                "/groupDetail",
                    (route) => false,
                arguments: {
                  "id": groupId,
                  "secondRoute": secondRoute,
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
      } catch (error) {
        // Handle errors
        print('Exception occurred: $error');
      }
    }
  }
}
