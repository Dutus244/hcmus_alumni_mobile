import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  OverlayEntry? _overlayEntry;

  ChatCreateController({required this.context});

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
    var endpoint = '/user';
    var pageSize = 20;

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
        // Pass the Map to the fromJson method
        var userResponse = UserResponse.fromJson(jsonMap);

        List<User> tempList = userResponse.users;

        for (int i = 0; i < tempList.length; i += 1) {
          if (tempList[i].id == Global.storageService.getUserId()) {
            tempList.removeAt(i);
          }
        }
        if (tempList.isEmpty) {
          if (page == 0) {
            context.read<ChatCreateBloc>().add(UsersEvent(tempList));
          }
          context.read<ChatCreateBloc>().add(HasReachedMaxUserEvent(true));
          context.read<ChatCreateBloc>().add(StatusEvent(Status.success));
          return;
        }
        if (page == 0) {
          context.read<ChatCreateBloc>().add(UsersEvent(tempList));
        } else {
          List<User> currentList =
              BlocProvider.of<ChatCreateBloc>(context).state.users;

          // Create a new list by adding newsResponse.news to the existing list
          List<User> updatedNewsList = List.of(currentList)..addAll(tempList);

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
      // toastInfo(msg: translate('error_get_user'));
    }
  }

  Future<void> handleCreateInbox(User user) async {
    context.read<ChatCreateBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
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
        context.read<ChatCreateBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();

        Navigator.pushNamed(context, "/chatDetail", arguments: {
          "inboxId": inboxId,
          "name": user.fullName,
        });
      } else {
        context.read<ChatCreateBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        // Handle other status codes if needed
        toastInfo(msg: "Có lỗi xả ra khi tạo cuộc hội thoại");
      }
    } catch (error) {
      // Handle errors
      // toastInfo(msg: "Có lỗi xả ra khi tạo cuộc hội thoại");
      hideLoadingIndicator();
      print(error);
    }
  }
}
