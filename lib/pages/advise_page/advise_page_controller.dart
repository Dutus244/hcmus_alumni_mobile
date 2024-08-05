import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/model/post.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/post_response.dart';
import 'bloc/advise_page_blocs.dart';
import 'package:http/http.dart' as http;

import 'bloc/advise_page_events.dart';
import 'bloc/advise_page_states.dart';

class AdvisePageController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  AdvisePageController({required this.context});

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

      if (response.statusCode == 200) {
        // Convert the JSON string to a Map
        var jsonMap = json.decode(responseBody);
        // Pass the Map to the fromJson method
        var postResponse = PostResponse.fromJson(jsonMap);
        if (postResponse.posts.isEmpty) {
          if (page == 0) {
            context.read<AdvisePageBloc>().add(PostsEvent(postResponse.posts));
          }
          context.read<AdvisePageBloc>().add(HasReachedMaxPostEvent(true));
          context.read<AdvisePageBloc>().add(StatusPostEvent(Status.success));
          return;
        }
        if (page == 0) {
          context.read<AdvisePageBloc>().add(PostsEvent(postResponse.posts));
        } else {
          List<Post> currentList =
              BlocProvider.of<AdvisePageBloc>(context).state.posts;

          // Create a new list by adding newsResponse.news to the existing list
          List<Post> updatedNewsList = List.of(currentList)
            ..addAll(postResponse.posts);

          context.read<AdvisePageBloc>().add(PostsEvent(updatedNewsList));
        }
        context.read<AdvisePageBloc>().add(StatusPostEvent(Status.success));

        if (postResponse.posts.length < pageSize) {
          context.read<AdvisePageBloc>().add(HasReachedMaxPostEvent(true));
        }
      } else {
        // Handle other status codes if needed
        // toastInfo(msg: translate('error_get_posts'));
      }
    } catch (error) {
      // Handle errors
      if (error.toString() !=
          "Looking up a deactivated widget's ancestor is unsafe.\nAt this point the state of the widget's element tree is no longer stable.\nTo safely refer to a widget's ancestor in its dispose() method, save a reference to the ancestor by calling dependOnInheritedWidgetOfExactType() in the widget's didChangeDependencies() method.") {
        // toastInfo(msg: translate('error_get_posts'));
      }
    }
  }

  Future<void> handleLikePost(String id) async {
    try {
      context.read<AdvisePageBloc>().add(IsLoadingEvent(true));
      showLoadingIndicator();
      List<Post> currentList =
          BlocProvider.of<AdvisePageBloc>(context).state.posts;

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
              context.read<AdvisePageBloc>().add(PostsEvent(currentList));
            } else {
              // Handle other status codes if needed
              toastInfo(msg: translate('error_unlike_post'));
            }
            context.read<AdvisePageBloc>().add(IsLoadingEvent(false));
            hideLoadingIndicator();
          } else {
            var response = await http.post(url, headers: headers, body: body);
            if (response.statusCode == 201) {
              currentList[i].reactionCount += 1;
              currentList[i].isReacted = true;
              context.read<AdvisePageBloc>().add(PostsEvent(currentList));
            } else {
              // Handle other status codes if needed
              toastInfo(msg: translate('error_like_post'));
            }
            context.read<AdvisePageBloc>().add(IsLoadingEvent(false));
            hideLoadingIndicator();
          }
        }
      }
    } catch (error) {
      hideLoadingIndicator();
    }
  }

  Future<bool> handleDeletePost(String id) async {
    final shouldDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(translate('delete_post')),
        content: Text(translate('delete_post_question')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(translate('cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(translate('delete')),
          ),
        ],
      ),
    );
    if (shouldDelete != null && shouldDelete) {
      context.read<AdvisePageBloc>().add(IsLoadingEvent(true));
      showLoadingIndicator();
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
          await handleLoadPostData(0);
          context.read<AdvisePageBloc>().add(IsLoadingEvent(false));
          hideLoadingIndicator();
          toastInfo(msg: 'Xoá bài viết thành công');
          return true;
        } else {
          // Handle other status codes if needed
          context.read<AdvisePageBloc>().add(IsLoadingEvent(false));
          hideLoadingIndicator();
          toastInfo(msg: translate('error_delete_post'));
          return false;
        }
      } catch (error) {
        // Handle errors
        hideLoadingIndicator();
        return false;
      }
    }
    return shouldDelete ?? false;
  }

  Future<void> handleVote(String id, int newVoteId) async {
    context.read<AdvisePageBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
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
        await handleLoadPostData(0);
        context.read<AdvisePageBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
      } else {
        // Handle other status codes if needed
        context.read<AdvisePageBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_choose_option'));
        return;
      }
    } catch (error) {
      // Handle errors
      hideLoadingIndicator();
      return;
    }
  }

  Future<void> handleDeleteVote(String id, int voteId) async {
    context.read<AdvisePageBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
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
        await handleLoadPostData(0);
        context.read<AdvisePageBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
      } else {
        // Handle other status codes if needed
        context.read<AdvisePageBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_not_choose_option'));
        return;
      }
    } catch (error) {
      // Handle errors
      hideLoadingIndicator();
      return;
    }
  }

  Future<void> handleUpdateVote(String id, int oldVoteId, int newVoteId) async {
    context.read<AdvisePageBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/$id/votes/$oldVoteId';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Specify content type as JSON
    };

    Map<String, dynamic> data = {
      'updatedVoteId': newVoteId
    }; // Define your JSON data
    var body = json.encode(data); // Encode the data to JSON
    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        await handleLoadPostData(0);
        context.read<AdvisePageBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
      } else {
        // Handle other status codes if needed
        context.read<AdvisePageBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_change_option'));
        return;
      }
    } catch (error) {
      // Handle errors
      hideLoadingIndicator();
      return;
    }
  }

  Future<void> handleAddVote(String id, String vote) async {
    context.read<AdvisePageBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/$id/votes';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final map = <String, dynamic>{};
    map['name'] = vote;

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response =
          await http.post(url, headers: headers, body: json.encode(map));
      if (response.statusCode == 201) {
        await handleLoadPostData(0);
        context.read<AdvisePageBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: 'Thêm lựa chọn thành công');
      } else {
        // Handle other status codes if needed
        context.read<AdvisePageBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_add_option'));
        return;
      }
    } catch (error) {
      // Handle errors
      hideLoadingIndicator();
      return;
    }
  }
}
