import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/event.dart';
import '../../model/event_response.dart';
import '../../model/post.dart';
import '../../model/post_response.dart';
import 'bloc/my_profile_page_blocs.dart';
import 'bloc/my_profile_page_events.dart';
import 'bloc/my_profile_page_states.dart';
import 'package:http/http.dart' as http;

class MyProfilePageController {
  final BuildContext context;

  const MyProfilePageController({required this.context});

  Future<void> handleLoadEventsData(int page) async {
    if (page == 0) {
      context.read<MyProfilePageBloc>().add(HasReachedMaxEventEvent(false));
      context.read<MyProfilePageBloc>().add(IndexEventEvent(1));
    } else {
      if (BlocProvider.of<MyProfilePageBloc>(context)
          .state
          .hasReachedMaxEvent) {
        return;
      }
      context.read<MyProfilePageBloc>().add(IndexEventEvent(
          BlocProvider.of<MyProfilePageBloc>(context).state.indexEvent + 1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/events';
    var pageSize = 5;
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse('$apiUrl$endpoint?page=$page&pageSize=$pageSize');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var eventResponse = EventResponse.fromJson(jsonMap);

        if (eventResponse.events.isEmpty) {
          if (page == 0) {
            context
                .read<MyProfilePageBloc>()
                .add(EventsEvent(eventResponse.events));
          }
          context.read<MyProfilePageBloc>().add(HasReachedMaxEventEvent(true));
          context
              .read<MyProfilePageBloc>()
              .add(StatusEventEvent(Status.success));
          return;
        }

        if (page == 0) {
          context
              .read<MyProfilePageBloc>()
              .add(EventsEvent(eventResponse.events));
        } else {
          List<Event> currentList =
              BlocProvider.of<MyProfilePageBloc>(context).state.events;
          List<Event> updatedEventList = List.of(currentList)
            ..addAll(eventResponse.events);
          context.read<MyProfilePageBloc>().add(EventsEvent(updatedEventList));
        }
        if (eventResponse.events.length < pageSize) {
          context.read<MyProfilePageBloc>().add(HasReachedMaxEventEvent(true));
        }
        context.read<MyProfilePageBloc>().add(StatusEventEvent(Status.success));
      } else {
        toastInfo(msg: "Có lỗi xả ra khi lấy danh sự kiện đã tham gia");
      }
    } catch (error) {
      toastInfo(msg: "Có lỗi xả ra khi lấy danh sự kiện đã tham gia");
    }
  }

  Future<void> handleLoadPostData(int page) async {
    if (page == 0) {
      context.read<MyProfilePageBloc>().add(HasReachedMaxPostEvent(false));
      context.read<MyProfilePageBloc>().add(IndexPostEvent(1));
    } else {
      if (BlocProvider.of<MyProfilePageBloc>(context).state.hasReachedMaxPost) {
        return;
      }
      context.read<MyProfilePageBloc>().add(IndexPostEvent(
          BlocProvider.of<MyProfilePageBloc>(context).state.indexPost + 1));
    }

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel';
    var pageSize = 5;

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
      print(responseBody);
      if (response.statusCode == 200) {
        // Convert the JSON string to a Map
        var jsonMap = json.decode(responseBody);
        // Pass the Map to the fromJson method
        var postResponse = PostResponse.fromJson(jsonMap);
        if (postResponse.posts.isEmpty) {
          if (page == 0) {
            context.read<MyProfilePageBloc>().add(PostsEvent(postResponse.posts));
          }
          context.read<MyProfilePageBloc>().add(HasReachedMaxPostEvent(true));
          context.read<MyProfilePageBloc>().add(StatusPostEvent(Status.success));
          return;
        }
        if (page == 0) {
          context.read<MyProfilePageBloc>().add(PostsEvent(postResponse.posts));
        } else {
          List<Post> currentList =
              BlocProvider.of<MyProfilePageBloc>(context).state.posts;

          // Create a new list by adding newsResponse.news to the existing list
          List<Post> updatedNewsList = List.of(currentList)
            ..addAll(postResponse.posts);

          context.read<MyProfilePageBloc>().add(PostsEvent(updatedNewsList));
        }
        context.read<MyProfilePageBloc>().add(StatusPostEvent(Status.success));

        if (postResponse.posts.length < pageSize) {
          context.read<MyProfilePageBloc>().add(HasReachedMaxPostEvent(true));
        }
      } else {
        // Handle other status codes if needed
        toastInfo(msg: "Có lỗi xả ra khi lấy danh bài viết của tôi");
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: "Có lỗi xả ra khi lấy danh bài viết của tôi");
    }
  }

  Future<void> handleLikePost(String id) async {
    List<Post> currentList =
        BlocProvider.of<MyProfilePageBloc>(context).state.posts;

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
            context.read<MyProfilePageBloc>().add(PostsEvent(currentList));
            return;
          } else {
            // Handle other status codes if needed
            toastInfo(msg: "Có lỗi xả ra khi huỷ thích bài viết");
          }
        } else {
          var response = await http.post(url, headers: headers, body: body);
          if (response.statusCode == 201) {
            currentList[i].reactionCount += 1;
            currentList[i].isReacted = true;
            context.read<MyProfilePageBloc>().add(PostsEvent(currentList));
            return;
          } else {
            // Handle other status codes if needed
            toastInfo(msg: "Có lỗi xả ra khi thích bài viết");
          }
        }
      }
    }
  }

  Future<bool> handleDeletePost(String id) async {
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
          MyProfilePageController(context: context).handleLoadPostData(0);
          return true;
        } else {
          // Handle other status codes if needed
          toastInfo(msg: "Có lỗi xả ra khi xoá bài viết");
        }
      } catch (error) {
        // Handle errors
        toastInfo(msg: "Có lỗi xả ra khi xoá bài viết");
      }
    }
    return shouldDelte ?? false;
  }

  Future<void> handleVote(String id, int newVoteId) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/$id/votes/$newVoteId';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Specify content type as JSON
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.post(url, headers: headers);
      if (response.statusCode == 201) {
        MyProfilePageController(context: context).handleLoadPostData(0);
      } else {
        // Handle other status codes if needed
        toastInfo(msg: "Có lỗi xả ra khi chọn lựa chọn");
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: "Có lỗi xả ra khi chọn lựa chọn");
    }
  }

  Future<void> handleDeleteVote(String id, int voteId) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/$id/votes/$voteId';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Specify content type as JSON
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        MyProfilePageController(context: context).handleLoadPostData(0);
      } else {
        // Handle other status codes if needed
        toastInfo(msg: "Có lỗi xả ra khi huỷ lựa chọn");
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: "Có lỗi xả ra khi huỷ lựa chọn");
    }
  }

  Future<void> handleUpdateVote(String id, int oldVoteId, int newVoteId) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/$id/votes/$oldVoteId';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Specify content type as JSON
    };

    Map<String, dynamic> data = {'updatedVoteId': newVoteId}; // Define your JSON data
    var body = json.encode(data); // Encode the data to JSON
    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        MyProfilePageController(context: context).handleLoadPostData(0);
      } else {
        // Handle other status codes if needed
        toastInfo(msg: "Có lỗi xả ra khi cập nhật lựa chọn");
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: "Có lỗi xả ra khi cập nhật lựa chọn");
    }
  }
}