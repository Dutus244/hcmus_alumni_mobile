import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcmus_alumni_mobile/model/friend_request.dart';
import 'package:hcmus_alumni_mobile/model/friend_request_response.dart';
import 'package:hcmus_alumni_mobile/model/friend_suggestion.dart';
import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'package:http/http.dart' as http;

import '../../model/friend_suggestion_response.dart';
import 'bloc/friend_page_blocs.dart';
import 'bloc/friend_page_events.dart';
import 'bloc/friend_page_states.dart';

class FriendPageController {
  final BuildContext context;

  const FriendPageController({required this.context});

  Future<void> handleSearchFriend() async {
    final state = context
        .read<FriendPageBloc>()
        .state;
    String name = state.name;
    context.read<FriendPageBloc>().add(NameSearchEvent(name));
    await Future.delayed(Duration(milliseconds: 100));
    handleLoadSuggestionData(0);
  }

  Future<void> handleLoadSuggestionData(int page) async {
    await Future.delayed(Duration(microseconds: 500));
    if (page == 0) {
      context.read<FriendPageBloc>().add(HasReachedMaxSuggestionEvent(false));
      context.read<FriendPageBloc>().add(IndexSuggestionEvent(1));
    } else {
      if (BlocProvider.of<FriendPageBloc>(context).state.hasReachedMaxSuggestion) {
        return;
      }
      context.read<FriendPageBloc>().add(IndexSuggestionEvent(
          BlocProvider.of<FriendPageBloc>(context).state.indexSuggestion + 1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/news';
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
        var suggestionResponse = FriendSuggestionResponse.fromJson(jsonMap);

        if (suggestionResponse.suggestions.isEmpty) {
          if (page == 0) {
            context.read<FriendPageBloc>().add(FriendSuggestionsEvent(suggestionResponse.suggestions));
          }
          context.read<FriendPageBloc>().add(HasReachedMaxSuggestionEvent(true));
          context
              .read<FriendPageBloc>()
              .add(StatusSuggestionEvent(Status.success));
          return;
        }

        if (page == 0) {
          context.read<FriendPageBloc>().add(FriendSuggestionsEvent(suggestionResponse.suggestions));
        } else {
          List<FriendSuggestion> currentList =
              BlocProvider.of<FriendPageBloc>(context).state.friendSuggestions;
          List<FriendSuggestion> updatedNewsList = List.of(currentList)
            ..addAll(suggestionResponse.suggestions);
          context.read<FriendPageBloc>().add(FriendSuggestionsEvent(updatedNewsList));
        }
        if (suggestionResponse.suggestions.length < pageSize) {
          context.read<FriendPageBloc>().add(HasReachedMaxSuggestionEvent(true));
        }
        context.read<FriendPageBloc>().add(StatusSuggestionEvent(Status.success));
      } else {
        toastInfo(msg: "Có lỗi xả ra khi lấy danh sách gợi ý bạn bè");
      }
    } catch (error) {
      toastInfo(msg: "Có lỗi xả ra khi lấy danh sách gợi ý bạn bè");
    }
  }

  Future<void> handleLoadRequestData(int page) async {
    if (page == 0) {
      context.read<FriendPageBloc>().add(HasReachedMaxRequestEvent(false));
      context.read<FriendPageBloc>().add(IndexRequestEvent(1));
    } else {
      if (BlocProvider.of<FriendPageBloc>(context).state.hasReachedMaxRequest) {
        return;
      }
      context.read<FriendPageBloc>().add(IndexRequestEvent(
          BlocProvider.of<FriendPageBloc>(context).state.indexRequest + 1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/news';
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
        var requestResponse = FriendRequestResponse.fromJson(jsonMap);

        if (requestResponse.requests.isEmpty) {
          if (page == 0) {
            context.read<FriendPageBloc>().add(FriendRequestsEvent(requestResponse.requests));
          }
          context.read<FriendPageBloc>().add(HasReachedMaxRequestEvent(true));
          context
              .read<FriendPageBloc>()
              .add(StatusRequestEvent(Status.success));
          return;
        }

        if (page == 0) {
          context.read<FriendPageBloc>().add(FriendRequestsEvent(requestResponse.requests));
        } else {
          List<FriendRequest> currentList =
              BlocProvider.of<FriendPageBloc>(context).state.friendRequests;
          List<FriendRequest> updatedNewsList = List.of(currentList)
            ..addAll(requestResponse.requests);
          context.read<FriendPageBloc>().add(FriendRequestsEvent(updatedNewsList));
        }
        if (requestResponse.requests.length < pageSize) {
          context.read<FriendPageBloc>().add(HasReachedMaxRequestEvent(true));
        }
        context.read<FriendPageBloc>().add(StatusRequestEvent(Status.success));
      } else {
        toastInfo(msg: "Có lỗi xả ra khi lấy danh sách lời mời kết bạn");
      }
    } catch (error) {
      toastInfo(msg: "Có lỗi xả ra khi lấy danh sách lời mời kết bạn");
    }
  }

  Future<void> handleApprovedRequest(String id) async  {

  }

  Future<void> handleDeneidRequest(String id) async  {

  }

  Future<void> handleSendRequest(String id) async {

  }
}