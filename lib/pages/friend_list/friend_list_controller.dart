import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/friend.dart';
import '../../model/friend_response.dart';
import 'bloc/friend_list_blocs.dart';
import 'bloc/friend_list_events.dart';
import 'bloc/friend_list_states.dart';

import 'package:http/http.dart' as http;

class FriendListController {
  final BuildContext context;

  const FriendListController({required this.context});

  Future<void> handleSearchFriend(String id) async {
    final state = context
        .read<FriendListBloc>()
        .state;
    String name = state.name;
    context.read<FriendListBloc>().add(NameSearchEvent(name));
    await Future.delayed(Duration(milliseconds: 100));
    handleLoadFriendData(0, id);
  }

  Future<void> handleLoadFriendData(int page, String id) async {
    await Future.delayed(Duration(microseconds: 500));
    if (page == 0) {
      context.read<FriendListBloc>().add(HasReachedMaxFriendEvent(false));
      context.read<FriendListBloc>().add(IndexFriendEvent(1));
    } else {
      if (BlocProvider.of<FriendListBloc>(context).state.hasReachedMaxFriend) {
        return;
      }
      context.read<FriendListBloc>().add(IndexFriendEvent(
          BlocProvider.of<FriendListBloc>(context).state.indexFriend + 1));
    }
    final state = context.read<FriendListBloc>().state;
    String name = state.nameSearch;

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/$id/friends';
    var pageSize = 20;

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };

    try {
      var url = Uri.parse(
          '$apiUrl$endpoint?page=$page&pageSize=$pageSize&fullName=$name');

      // Specify UTF-8 encoding for decoding response
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        // Convert the JSON string to a Map
        var jsonMap = json.decode(responseBody);
        // Pass the Map to the fromJson method
        var friendResponse = FriendResponse.fromJson(jsonMap);
        if (friendResponse.friends.isEmpty) {
          if (page == 0) {
            context
                .read<FriendListBloc>()
                .add(FriendsEvent(friendResponse.friends));
          }
          context.read<FriendListBloc>().add(HasReachedMaxFriendEvent(true));
          context.read<FriendListBloc>().add(StatusEvent(Status.success));
          return;
        }
        if (page == 0) {
          context
              .read<FriendListBloc>()
              .add(FriendsEvent(friendResponse.friends));
        } else {
          List<Friend> currentList =
              BlocProvider.of<FriendListBloc>(context).state.friends;

          // Create a new list by adding newsResponse.news to the existing list
          List<Friend> updatedNewsList = List.of(currentList)
            ..addAll(friendResponse.friends);

          context.read<FriendListBloc>().add(FriendsEvent(updatedNewsList));
        }
        context.read<FriendListBloc>().add(StatusEvent(Status.success));

        if (friendResponse.friends.length < pageSize) {
          context.read<FriendListBloc>().add(HasReachedMaxFriendEvent(true));
        }
      } else {
        // Handle other status codes if needed
        print(responseBody);
        toastInfo(msg: translate('error_get_friend'));
      }
    } catch (error) {
      // Handle errors
      print(error);
      toastInfo(msg: translate('error_get_friend'));
    }
  }

  Future<bool> handleDeleteFriend(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/friends/$id';
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    try {
      // Send the request
      var response = await http.delete(
        Uri.parse('$apiUrl$endpoint'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        handleLoadFriendData(0, id);
        handleGetFriendCount(id);
        return true;
      } else {
        toastInfo(msg: translate('error_verify_alumni'));
        return false;
      }
    } catch (e) {
      // Exception occurred
      toastInfo(msg: translate('error_verify_alumni'));
      print(e);
      return false;
    }
  }

  Future<void> handleGetFriendCount(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/$id/friends/count';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };

    try {
      var url = Uri.parse(
          '$apiUrl$endpoint');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      context.read<FriendListBloc>().add(FriendCountEvent(int.parse(responseBody)));
    } catch (error) {
      print(error);
    }
  }
}