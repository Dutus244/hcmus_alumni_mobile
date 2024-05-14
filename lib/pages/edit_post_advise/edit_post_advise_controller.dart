import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:multi_dropdown/models/value_item.dart';
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
    return tags.map((tag) => {'id': tag}).toList();
  }

  Future<void> handleLoad(Post post) async {

    List<String> tagsId = post.tags.map((tag) => tag.id.toString()).toList();
    context.read<EditPostAdviseBloc>().add(TagsEvent(tagsId));
    List<ValueItem> initialSelectedItems = [
      ValueItem(label: 'Cựu sinh viên', value: '1'),
      ValueItem(label: 'Trường học', value: '2'),
      ValueItem(label: 'Cộng đồng', value: '3'),
      ValueItem(label: 'Khởi nghiệp', value: '4'),
      ValueItem(label: 'Nghề nghiệp', value: '5'),
      ValueItem(label: 'Học tập', value: '6'),
      ValueItem(label: 'Việc làm', value: '7'),
    ].where((item) => tagsId.contains(item.value)).toList();
    context.read<EditPostAdviseBloc>().add(ItemTagsEvent(initialSelectedItems));
    context.read<EditPostAdviseBloc>().add(TitleEvent(post.title));
    context.read<EditPostAdviseBloc>().add(ContentEvent(post.content));
    context.read<EditPostAdviseBloc>().add(PictureNetworkEvent(post.picture));
  }

  Future<void> handlePost(String id) async {
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
      var responseBody = utf8.decode(response.bodyBytes);
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
            Navigator.of(context).pushNamedAndRemoveUntil(
              "/applicationPage",
              (route) => false,
              arguments: {
                "route": 2,
                "secondRoute": 0,
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
    } catch (error, stacktrace) {
      // Handle errors
    }
  }
}
