import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcmus_alumni_mobile/model/post.dart';
import 'package:hcmus_alumni_mobile/pages/write_post_advise/bloc/write_post_advise_blocs.dart';

import '../../global.dart';
import '../../model/post_response.dart';
import 'bloc/advise_page_blocs.dart';
import 'package:http/http.dart' as http;

import 'bloc/advise_page_events.dart';
import 'bloc/advise_page_states.dart';

class AdvisePageController {
  final BuildContext context;

  const AdvisePageController({required this.context});

  Future<void> handleLoadPostData(int page) async {
    if (page == 0) {
      context.read<AdvisePageBloc>().add(HasReachedMaxPostEvent(false));
      context.read<AdvisePageBloc>().add(IndexPostEvent(1));
    } else {
      if (BlocProvider.of<AdvisePageBloc>(context).state.hasReachedMaxPost) {
        return;
      }
      context.read<AdvisePageBloc>().add(IndexPostEvent(
          BlocProvider.of<AdvisePageBloc>(context).state.indexPost + 1));
    }

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel';
    var pageSize = '5';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };
    // await Future.delayed(Duration(microseconds: 500));
    try {
      var url = Uri.parse('$apiUrl$endpoint?page=$page&pageSize=$pageSize');

      // Specify UTF-8 encoding for decoding response
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        // Convert the JSON string to a Map
        var jsonMap = json.decode(responseBody);
        // Pass the Map to the fromJson method
        var postResponse = PostResponse.fromJson(jsonMap);
        if (postResponse.post.isEmpty) {
          context.read<AdvisePageBloc>().add(PostEvent(postResponse.post));
          context.read<AdvisePageBloc>().add(HasReachedMaxPostEvent(true));
          context.read<AdvisePageBloc>().add(StatusPostEvent(Status.success));
          return;
        }
        if (page == 0) {
          context.read<AdvisePageBloc>().add(PostEvent(postResponse.post));
        } else {
          List<Post> currentList =
              BlocProvider.of<AdvisePageBloc>(context).state.post;

          // Create a new list by adding newsResponse.news to the existing list
          List<Post> updatedNewsList = List.of(currentList)
            ..addAll(postResponse.post);

          context.read<AdvisePageBloc>().add(PostEvent(updatedNewsList));
        }
        context.read<AdvisePageBloc>().add(StatusPostEvent(Status.success));

        if (postResponse.post.length < 5) {
          context.read<AdvisePageBloc>().add(HasReachedMaxPostEvent(true));
        }
      } else {
        // Handle other status codes if needed
      }
    } catch (error, stacktrace) {
      // Handle errors
    }
  }

  Future<void> handleLikePost(String id) async {
    List<Post> currentList =
        BlocProvider.of<AdvisePageBloc>(context).state.post;

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/$id/react';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Specify content type as JSON
    };

    Map<String, dynamic> data = {'reactId': 1}; // Define your JSON data
    var body = json.encode(data); // Encode the data to JSON
    var url = Uri.parse('$apiUrl$endpoint');

    for (var i = 0; i < currentList.length; i += 1) {
      if (currentList[i].id == id) {
        if (currentList[i].isReacted) {
          var response = await http.delete(url, headers: headers);
          if (response.statusCode == 200) {
            currentList[i].reactionCount -= 1;
            currentList[i].isReacted = false;
            context.read<AdvisePageBloc>().add(PostEvent(currentList));
            return;
          } else {
            // Handle other status codes if needed
          }
        } else {
          var response = await http.post(url, headers: headers, body: body);
          if (response.statusCode == 201) {
            currentList[i].reactionCount += 1;
            currentList[i].isReacted = true;
            context.read<AdvisePageBloc>().add(PostEvent(currentList));
            return;
          } else {
            // Handle other status codes if needed
          }
        }
      }
    }
  }

  Future<void> handleDeletePost(String id) async {
    final shouldDelte = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Xoá bài viết'),
        content: Text('Bạn có muốn xoá bài viết này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Huỷ'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Xoá'),
          ),
        ],
      ),
    );
    if (shouldDelte != null && shouldDelte) {
      var apiUrl = dotenv.env['API_URL'];
      var endpoint = '/counsel/$id';

      var token = Global.storageService.getUserAuthToken();

      var headers = <String, String>{
        'Authorization': 'Bearer $token',
      };

      try {
        var url = Uri.parse('$apiUrl$endpoint');

        var response = await http.delete(url, headers: headers);
        if (response.statusCode == 200) {
          AdvisePageController(context: context).handleLoadPostData(0);
        } else {
          // Handle other status codes if needed
        }
      } catch (error, stacktrace) {
        // Handle errors
      }
    }
    return shouldDelte ?? false;
  }
}