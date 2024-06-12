import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:multi_dropdown/models/value_item.dart';
import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/post.dart';
import 'bloc/edit_post_advise_blocs.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'bloc/edit_post_advise_events.dart';

class EditPostAdviseController {
  final BuildContext context;

  const EditPostAdviseController({required this.context});

  List<Map<String, dynamic>> convertTagsToJson(List<String> tags) {
    return tags.map((tag) => {'name': tag}).toList();
  }

  Future<void> handleLoad(Post post) async {

    List<String> tags = post.tags.map((tag) => tag.name.toString()).toList();
    context.read<EditPostAdviseBloc>().add(TagsEvent(tags));
    context.read<EditPostAdviseBloc>().add(TitleEvent(post.title));
    context.read<EditPostAdviseBloc>().add(ContentEvent(post.content));
    context.read<EditPostAdviseBloc>().add(PictureNetworksEvent(post.pictures));
  }

  Future<void> handlePost(String id, int route, int profile, String page) async {
    final state = context.read<EditPostAdviseBloc>().state;
    String title = state.title;
    String content = state.content;
    List<String> tags = state.tags;
    List<File> pictures = state.pictures;
    List<String> deletePictures = state.deletePictures;


    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/$id';

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

      var response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        var endpoint =
            '/counsel/$id/images';

        var headers = <String, String>{
          'Authorization': 'Bearer $token',
          "Content-Type": "multipart/form-data"
        };

        var request =
            http.MultipartRequest('PUT', Uri.parse('$apiUrl$endpoint'));
        request.headers.addAll(headers);
        request.fields['deletedImageIds'] = deletePictures.join(',');

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
                .read<EditPostAdviseBloc>()
                .add(EditPostAdviseResetEvent());
            if (profile == 0) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                "/applicationPage",
                    (route) => false,
                arguments: {
                  "route": route,
                  "secondRoute": 0,
                },
              );
            }
            else {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/myProfilePage", (route) => false,
                  arguments: {"page": page, "route": route});
            }
          } else {
            toastInfo(msg: "Có lỗi xảy ra khi chỉnh sửa bài tư vấn");
            return;
          }
        } catch (e) {
          // Exception occurred
          toastInfo(msg: "Có lỗi xảy ra khi chỉnh sửa bài tư vấn");
          return;
        }
      } else {
        // Handle other status codes if needed
        toastInfo(msg: "Có lỗi xảy ra khi chỉnh sửa bài tư vấn");
        return;
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: "Có lỗi xảy ra khi chỉnh sửa bài tư vấn");
      return;
    }
  }
}
