import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcmus_alumni_mobile/model/inbox.dart';
import 'package:http/http.dart' as http;

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/inbox_response.dart';
import 'bloc/chat_page_blocs.dart';
import 'bloc/chat_page_events.dart';
import 'bloc/chat_page_states.dart';

class ChatPageController {
  final BuildContext context;

  const ChatPageController({required this.context});

  Future<void> handleSearchInbox() async {
    final state = context
        .read<ChatPageBloc>()
        .state;
    String name = state.name;
    context.read<ChatPageBloc>().add(NameSearchEvent(name));
    await Future.delayed(Duration(milliseconds: 100));
    handleLoadInboxData(0);
  }

  Future<void> handleLoadInboxData(int page) async {
    await Future.delayed(Duration(seconds: 1));
    if (page == 0) {
      context.read<ChatPageBloc>().add(HasReachedMaxInboxEvent(false));
      context.read<ChatPageBloc>().add(IndexInboxEvent(1));
    } else {
      if (BlocProvider.of<ChatPageBloc>(context).state.hasReachedMaxInbox) {
        return;
      }
      context.read<ChatPageBloc>().add(IndexInboxEvent(
          BlocProvider.of<ChatPageBloc>(context).state.indexInbox + 1));
    }
    
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/messages/inbox';
    var pageSize = 10;

    var token = Global.storageService.getUserAuthToken();
    final state = context
        .read<ChatPageBloc>()
        .state;
    String nameSearch = state.nameSearch;

    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };

    try {
      var url = Uri.parse(
          '$apiUrl$endpoint?page=$page&pageSize=$pageSize&query=$nameSearch');

      // Specify UTF-8 encoding for decoding response
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        // Convert the JSON string to a Map
        var jsonMap = json.decode(responseBody);
        // Pass the Map to the fromJson method
        var inboxResponse = InboxResponse.fromJson(jsonMap);
        if (inboxResponse.inboxes.isEmpty) {
          if (page == 0) {
            context
                .read<ChatPageBloc>()
                .add(InboxesEvent(inboxResponse.inboxes));
          }
          context.read<ChatPageBloc>().add(HasReachedMaxInboxEvent(true));
          context.read<ChatPageBloc>().add(StatusEvent(Status.success));
          return;
        }
        if (page == 0) {
          context
              .read<ChatPageBloc>()
              .add(InboxesEvent(inboxResponse.inboxes));
        } else {
          List<Inbox> currentList =
              BlocProvider.of<ChatPageBloc>(context).state.inboxes;

          // Create a new list by adding newsResponse.news to the existing list
          List<Inbox> updatedNewsList = List.of(currentList)
            ..addAll(inboxResponse.inboxes);

          context.read<ChatPageBloc>().add(InboxesEvent(updatedNewsList));
        }
        context.read<ChatPageBloc>().add(StatusEvent(Status.success));

        if (inboxResponse.inboxes.length < pageSize) {
          context.read<ChatPageBloc>().add(HasReachedMaxInboxEvent(true));
        }
      } else {
        // Handle other status codes if needed
        toastInfo(msg: "Có lỗi xả ra khi lấy danh sách bạn bè");
      }
    } catch (error) {
      // Handle errors
      // toastInfo(msg: "Có lỗi xả ra khi lấy danh sách bạn bè");
    }
  }
}