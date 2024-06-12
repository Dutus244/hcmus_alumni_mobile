import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/group.dart';
import '../../model/post.dart';
import '../../model/post_response.dart';
import 'bloc/group_detail_blocs.dart';
import 'bloc/group_detail_events.dart';
import 'bloc/group_detail_states.dart';

class GroupDetailController {
  final BuildContext context;

  const GroupDetailController({required this.context});

  Future<void> handleGetGroup(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$id';
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
        var group = Group.fromJson(jsonMap);
        context.read< GroupDetailBloc>().add(GroupEvent(group));
      } else {
        toastInfo(msg: "Có lỗi xả ra khi lấy thông tin nhóm");
      }
    } catch (error) {
      toastInfo(msg: "Có lỗi xả ra khi lấy thông tin nhóm");
    }
  }

  Future<void> handleLoadPostData(String id, int page) async {
    if (page == 0) {
      context.read<GroupDetailBloc>().add(HasReachedMaxPostEvent(false));
      context.read<GroupDetailBloc>().add(IndexPostEvent(1));
    } else {
      if (BlocProvider.of<GroupDetailBloc>(context).state.hasReachedMaxPost) {
        return;
      }
      context.read<GroupDetailBloc>().add(IndexPostEvent(
          BlocProvider.of<GroupDetailBloc>(context).state.indexPost + 1));
    }

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$id/posts';
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
        if (postResponse.posts.isEmpty) {
          if (page == 0) {
            context.read<GroupDetailBloc>().add(PostsEvent(postResponse.posts));
          }
          context.read<GroupDetailBloc>().add(HasReachedMaxPostEvent(true));
          context.read<GroupDetailBloc>().add(StatusPostEvent(Status.success));
          return;
        }
        if (page == 0) {
          context.read<GroupDetailBloc>().add(PostsEvent(postResponse.posts));
        } else {
          List<Post> currentList =
              BlocProvider.of<GroupDetailBloc>(context).state.posts;

          // Create a new list by adding newsResponse.news to the existing list
          List<Post> updatedNewsList = List.of(currentList)
            ..addAll(postResponse.posts);

          context.read<GroupDetailBloc>().add(PostsEvent(updatedNewsList));
        }
        context.read<GroupDetailBloc>().add(StatusPostEvent(Status.success));

        if (postResponse.posts.length < 5) {
          context.read<GroupDetailBloc>().add(HasReachedMaxPostEvent(true));
        }
      } else {
        // Handle other status codes if needed
        toastInfo(msg: "Có lỗi xả ra khi lấy danh sách bài viết nhóm");
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: "Có lỗi xả ra khi lấy danh sách bài viết nhóm");
    }
  }

  Future<void> handleRequestJoinGroup(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$id/requests';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.post(url, headers: headers);
      if (response.statusCode == 201) {
        GroupDetailController(context: context).handleGetGroup(id);
      } else {
        // Handle other status codes if needed
        toastInfo(msg: "Có lỗi xả ra khi tham gia nhóm");
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: "Có lỗi xả ra khi tham gia nhóm");
    }
  }

  Future<bool> handleDeletePost(String id, String groupId) async {
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
      var endpoint = '/groups/posts/$id';

      var token = Global.storageService.getUserAuthToken();

      var headers = <String, String>{
        'Authorization': 'Bearer $token',
      };

      try {
        var url = Uri.parse('$apiUrl$endpoint');

        var response = await http.delete(url, headers: headers);
        if (response.statusCode == 200) {
          GroupDetailController(context: context).handleLoadPostData(groupId, 0);
          return true;
        } else {
          // Handle other status codes if needed
          toastInfo(msg: "Có lỗi xả ra khi xoá bài viết nhóm");
        }
      } catch (error) {
        // Handle errors
        toastInfo(msg: "Có lỗi xả ra khi xoá bài viết nhóm");
      }
    }
    return shouldDelte ?? false;
  }

  Future<void> handleLikePost(String id) async {
    List<Post> currentList =
        BlocProvider.of<GroupDetailBloc>(context).state.posts;

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$id/react';

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
            context.read<GroupDetailBloc>().add(PostsEvent(currentList));
            return;
          } else {
            // Handle other status codes if needed
            toastInfo(msg: "Có lỗi xả ra khi huỷ thích bài viết nhóm");
          }
        } else {
          var response = await http.post(url, headers: headers, body: body);
          if (response.statusCode == 201) {
            currentList[i].reactionCount += 1;
            currentList[i].isReacted = true;
            context.read<GroupDetailBloc>().add(PostsEvent(currentList));
            return;
          } else {
            // Handle other status codes if needed
            toastInfo(msg: "Có lỗi xả ra khi thích bài viết nhóm");
          }
        }
      }
    }
  }

  Future<void> handleExitGroup(String id, int secondRoute) async {
    String userId = '30ff6fa7-035f-42e4-aa13-55c1c94ded1e';
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$id/members/$userId';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/applicationPage", (route) => false,
            arguments: {"route": 3, "secondRoute": secondRoute});
      } else {
        // Handle other status codes if needed
        toastInfo(msg: "Có lỗi xả ra khi thoát nhóm");
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: "Có lỗi xả ra khi thoát nhóm");
    }
  }

  Future<void> handleVote(String groupId, String id, int newVoteId) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$id/votes/$newVoteId';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Specify content type as JSON
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.post(url, headers: headers);
      if (response.statusCode == 201) {
        GroupDetailController(context: context).handleLoadPostData(groupId, 0);
      } else {
        // Handle other status codes if needed
        toastInfo(msg: "Có lỗi xảy ra khi chọn lựa chọn");
        return;
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: "Có lỗi xảy ra khi chọn lựa chọn");
      return;
    }
  }

  Future<void> handleDeleteVote(String groupId, String id, int voteId) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$id/votes/$voteId';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Specify content type as JSON
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        GroupDetailController(context: context).handleLoadPostData(groupId, 0);
      } else {
        // Handle other status codes if needed
        toastInfo(msg: "Có lỗi xảy ra khi huỷ lựa chọn");
        return;
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: "Có lỗi xảy ra khi huỷ lựa chọn");
      return;
    }
  }

  Future<void> handleUpdateVote(String groupId, String id, int oldVoteId, int newVoteId) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$id/votes/$oldVoteId';

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
        GroupDetailController(context: context).handleLoadPostData(groupId, 0);
      } else {
        // Handle other status codes if needed
        toastInfo(msg: "Có lỗi xảy ra khi chọn lựa chọn");
        return;
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: "Có lỗi xảy ra khi chọn lựa chọn");
      return;
    }
  }

  Future<void> handleAddVote(String groupId, String id, String vote) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$id/votes';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final map = <String, dynamic>{};
    map['name'] = vote;
    print(vote);

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.post(url, headers: headers, body: json.encode(map));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201) {
        GroupDetailController(context: context).handleLoadPostData(groupId, 0);
      } else {
        // Handle other status codes if needed
        toastInfo(msg: "Có lỗi xảy ra khi thêm lựa chọn");
        return;
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: "Có lỗi xảy ra khi thêm lựa chọn");
      return;
    }
  }
}