import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/post.dart';
import 'bloc/edit_post_group_blocs.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'bloc/edit_post_group_events.dart';

class EditPostGroupController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  EditPostGroupController({required this.context});

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

  Future<void> handleLoad(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/posts/$id';
    var token = Global.storageService.getUserAuthToken();
    var headers = <String, String>{
      'Authorization': 'Bearer $token',
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var post = Post.fromJson(jsonMap);
        context.read<EditPostGroupBloc>().add(EditPostGroupResetEvent());
        List<String> tags = post.tags.map((tag) => tag.name.toString()).toList();
        context.read<EditPostGroupBloc>().add(TagsEvent(tags));
        context.read<EditPostGroupBloc>().add(TitleEvent(post.title));
        context.read<EditPostGroupBloc>().add(ContentEvent(post.content));
        context.read<EditPostGroupBloc>().add(PictureNetworksEvent(post.pictures));
      } else {
        toastInfo(msg: translate('error_get_post'));
      }
    } catch (error) {
      // toastInfo(msg: translate('error_get_post'));
    }
  }

  Future<void> handlePost(String id, String groupId) async {
    context.read<EditPostGroupBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
    final state = context.read<EditPostGroupBloc>().state;
    String title = state.title;
    String content = state.content;
    List<String> tags = state.tags;
    List<File> pictures = state.pictures;
    List<String> deletePictures = state.deletePictures;

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/posts/$id';

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
        var endpoint = '/groups/posts/$id/images';

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
            context.read<EditPostGroupBloc>().add(EditPostGroupResetEvent());
            context.read<EditPostGroupBloc>().add(IsLoadingEvent(false));
            hideLoadingIndicator();
            toastInfo(msg: "Chỉnh sửa bài viết thành công");
            Navigator.pop(context);
          } else {
            context.read<EditPostGroupBloc>().add(IsLoadingEvent(false));
            hideLoadingIndicator();
            toastInfo(msg: translate('error_edit_post'));
            return;
          }
        } catch (e) {
          // Exception occurred
          // toastInfo(msg: translate('error_edit_post'));
          return;
        }
      } else {
        context.read<EditPostGroupBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        // Handle other status codes if needed
        toastInfo(msg: translate('error_edit_post'));
        return;
      }
    } catch (error) {
      // Handle errors
      // toastInfo(msg: translate('error_edit_post'));
      print('fuck');
      print(error);
      hideLoadingIndicator();
      return;
    }
  }
}
