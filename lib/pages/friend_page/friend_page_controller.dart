import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
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
    final state = context.read<FriendPageBloc>().state;
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
      if (BlocProvider.of<FriendPageBloc>(context)
          .state
          .hasReachedMaxSuggestion) {
        return;
      }
      context.read<FriendPageBloc>().add(IndexSuggestionEvent(
          BlocProvider.of<FriendPageBloc>(context).state.indexSuggestion + 1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user';
    var pageSize = 20;
    var token = Global.storageService.getUserAuthToken();
    String nameSearch = context.read<FriendPageBloc>().state.nameSearch;

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          '$apiUrl$endpoint?page=$page&pageSize=$pageSize&fullName=$nameSearch');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var suggestionResponse = FriendSuggestionResponse.fromJson(jsonMap);

        List<FriendSuggestion> tempList = suggestionResponse.suggestions;

        for (int i = 0; i < tempList.length; i += 1) {
          if (tempList[i].user.id == Global.storageService.getUserId()) {
            tempList.removeAt(i);
          }
        }

        if (tempList.isEmpty) {
          if (page == 0) {
            context
                .read<FriendPageBloc>()
                .add(FriendSuggestionsEvent(tempList));
          }
          context
              .read<FriendPageBloc>()
              .add(HasReachedMaxSuggestionEvent(true));
          context
              .read<FriendPageBloc>()
              .add(StatusSuggestionEvent(Status.success));
          return;
        }

        if (page == 0) {
          context.read<FriendPageBloc>().add(FriendSuggestionsEvent(tempList));
        } else {
          List<FriendSuggestion> currentList =
              BlocProvider.of<FriendPageBloc>(context).state.friendSuggestions;
          List<FriendSuggestion> updatedNewsList = List.of(currentList)
            ..addAll(tempList);
          context
              .read<FriendPageBloc>()
              .add(FriendSuggestionsEvent(updatedNewsList));
        }
        if (suggestionResponse.suggestions.length < pageSize) {
          context
              .read<FriendPageBloc>()
              .add(HasReachedMaxSuggestionEvent(true));
        }
        context
            .read<FriendPageBloc>()
            .add(StatusSuggestionEvent(Status.success));
      } else {
        toastInfo(msg: translate('error_get_user'));
      }
    } catch (error) {
      toastInfo(msg: translate('error_get_user'));
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
    var endpoint = '/user/friends/requests';
    var pageSize = 10;
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
            context
                .read<FriendPageBloc>()
                .add(FriendRequestsEvent(requestResponse.requests));
          }
          context.read<FriendPageBloc>().add(HasReachedMaxRequestEvent(true));
          context
              .read<FriendPageBloc>()
              .add(StatusRequestEvent(Status.success));
          return;
        }

        if (page == 0) {
          context
              .read<FriendPageBloc>()
              .add(FriendRequestsEvent(requestResponse.requests));
        } else {
          List<FriendRequest> currentList =
              BlocProvider.of<FriendPageBloc>(context).state.friendRequests;
          List<FriendRequest> updatedNewsList = List.of(currentList)
            ..addAll(requestResponse.requests);
          context
              .read<FriendPageBloc>()
              .add(FriendRequestsEvent(updatedNewsList));
        }
        if (requestResponse.requests.length < pageSize) {
          context.read<FriendPageBloc>().add(HasReachedMaxRequestEvent(true));
        }
        context.read<FriendPageBloc>().add(StatusRequestEvent(Status.success));
      } else {
        toastInfo(msg: translate('error_get_request'));
      }
    } catch (error) {
      toastInfo(msg: translate('error_get_request'));
    }
  }

  Future<void> handleApprovedRequest(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/friends/requests';
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var body = json.encode({
      'friendId': id,
      'action': 'ACCEPT'
    });

    try {
      // Send the request
      var response = await http.put(
        Uri.parse('$apiUrl$endpoint'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        handleLoadRequestData(0);
      } else {
        toastInfo(msg: translate('error_verify_alumni'));
      }
    } catch (e) {
      // Exception occurred
      toastInfo(msg: translate('error_verify_alumni'));
      print(e);
      return;
    }
  }

  Future<void> handleDeniedRequest(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/friends/requests';
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var body = json.encode({
      'friendId': id,
      'action': 'DENY'
    });

    try {
      // Send the request
      var response = await http.put(
        Uri.parse('$apiUrl$endpoint'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        handleLoadRequestData(0);
      } else {
        toastInfo(msg: translate('error_verify_alumni'));
      }
    } catch (e) {
      // Exception occurred
      toastInfo(msg: translate('error_verify_alumni'));
      print(e);
      return;
    }
  }

  Future<void> handleSendRequest(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/friends/requests';
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var body = json.encode({
      'friendId': id,
    });

    try {
      // Send the request
      var response = await http.post(
        Uri.parse('$apiUrl$endpoint'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
      } else {
        toastInfo(msg: translate('error_verify_alumni'));
      }
    } catch (e) {
      // Exception occurred
      toastInfo(msg: translate('error_verify_alumni'));
      print(e);
      return;
    }
  }
}
