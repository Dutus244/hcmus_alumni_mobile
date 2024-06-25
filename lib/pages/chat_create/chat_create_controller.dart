import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/user.dart';
import '../../model/user_response.dart';
import 'bloc/chat_create_blocs.dart';
import 'bloc/chat_create_events.dart';
import 'bloc/chat_create_states.dart';

class ChatCreateController {
  final BuildContext context;

  const ChatCreateController({required this.context});

  List<Map<String, dynamic>> convertTagsToJson(List<User> users) {
    return users.map((user) => {'userId': user.id}).toList();
  }

  Future<void> handleSearchUser() async {
    final state = context.read<ChatCreateBloc>().state;
    String name = state.name;
    context.read<ChatCreateBloc>().add(NameSearchEvent(name));
    await Future.delayed(Duration(milliseconds: 100));
    handleLoadUserData(0);
  }

  Future<void> handleLoadUserData(int page) async {
    await Future.delayed(Duration(microseconds: 500));
    if (page == 0) {
      context.read<ChatCreateBloc>().add(HasReachedMaxUserEvent(false));
      context.read<ChatCreateBloc>().add(IndexUserEvent(1));
    } else {
      if (BlocProvider.of<ChatCreateBloc>(context).state.hasReachedMaxUser) {
        return;
      }
      context.read<ChatCreateBloc>().add(IndexUserEvent(
          BlocProvider.of<ChatCreateBloc>(context).state.indexUser + 1));
    }
    final state = context.read<ChatCreateBloc>().state;
    String name = state.nameSearch;

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups';
    var pageSize = 5;

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };

    try {
      var url = Uri.parse(
          '$apiUrl$endpoint?page=$page&pageSize=$pageSize&name=$name');

      // Specify UTF-8 encoding for decoding response
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        // Convert the JSON string to a Map
        var jsonMap = json.decode(responseBody);
        jsonMap = {
          "users": [
            {
              "id": "0ac25d55-1ee6-4794-8d46-58f82cde644c",
              "fullName": "Test 9",
              "avatarUrl":
                  "https://storage.googleapis.com/hcmus-alumverse/images/users/avatar/c201bfdf3aadfe93c59f148a039322da99d8d96fdbba4055852689c761a9f8ea"
            },
            {
              "id": "16364790-7770-40d3-a517-7cd932cc3f8c",
              "fullName": "Test 6",
              "avatarUrl":
                  "https://storage.googleapis.com/hcmus-alumverse/images/users/avatar/c201bfdf3aadfe93c59f148a039322da99d8d96fdbba4055852689c761a9f8ea"
            },
            {
              "id": "360e7456-2fe9-410b-b17f-70295df95641",
              "fullName": "Test 8",
              "avatarUrl":
                  "https://storage.googleapis.com/hcmus-alumverse/images/users/avatar/c201bfdf3aadfe93c59f148a039322da99d8d96fdbba4055852689c761a9f8ea"
            },
          ]
        };
        // Pass the Map to the fromJson method
        var userResponse = UserResponse.fromJson(jsonMap);
        if (userResponse.users.isEmpty) {
          if (page == 0) {
            context.read<ChatCreateBloc>().add(UsersEvent(userResponse.users));
          }
          context.read<ChatCreateBloc>().add(HasReachedMaxUserEvent(true));
          context.read<ChatCreateBloc>().add(StatusEvent(Status.success));
          return;
        }
        if (page == 0) {
          context.read<ChatCreateBloc>().add(UsersEvent(userResponse.users));
        } else {
          List<User> currentList =
              BlocProvider.of<ChatCreateBloc>(context).state.users;

          // Create a new list by adding newsResponse.news to the existing list
          List<User> updatedNewsList = List.of(currentList)
            ..addAll(userResponse.users);

          context.read<ChatCreateBloc>().add(UsersEvent(updatedNewsList));
        }
        context.read<ChatCreateBloc>().add(StatusEvent(Status.success));

        if (userResponse.users.length < pageSize) {
          context.read<ChatCreateBloc>().add(HasReachedMaxUserEvent(true));
        }
      } else {
        // Handle other status codes if needed
        toastInfo(msg: translate('error_get_user'));
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: translate('error_get_user'));
    }
  }

  Future<void> handleCreateInbox(User user) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/messages/inbox';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    var temp = {'id': user.id}; // Example user object
    Map data = {
      'members': [
        {
          'userId': temp['id'],
        }
      ]
    };

    var body = json.encode(data);

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        int inboxId = jsonMap['inboxId'];

        Navigator.pushNamed(context, "/chatDetail", arguments: {
          "inboxId": inboxId,
          "name": user.fullName,
        });
      } else {
        // Handle other status codes if needed
        toastInfo(msg: "Có lỗi xả ra khi tạo cuộc hội thoại");
        print(response.body);
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: "Có lỗi xả ra khi tạo cuộc hội thoại");
      print(error);
    }
  }
}
