import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../global.dart';
import '../../model/group.dart';
import '../../model/group_response.dart';
import 'bloc/group_page_blocs.dart';
import 'bloc/group_page_events.dart';
import 'bloc/group_page_states.dart';
import 'package:http/http.dart' as http;

class GroupPageController {
  final BuildContext context;

  const GroupPageController({required this.context});

  Future<void> handleLoadGroupDiscoverData(int page) async {
    if (page == 0) {
      context.read<GroupPageBloc>().add(HasReachedMaxGroupDiscoverEvent(false));
      context.read<GroupPageBloc>().add(IndexGroupDiscoverEvent(1));
    } else {
      if (BlocProvider.of<GroupPageBloc>(context)
          .state
          .hasReachedMaxGroupDiscover) {
        return;
      }
      context.read<GroupPageBloc>().add(IndexGroupDiscoverEvent(
          BlocProvider.of<GroupPageBloc>(context).state.indexGroupDiscover +
              1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups';
    var pageSize = 6;
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
        var groupResponse = GroupResponse.fromJson(jsonMap);
        if (groupResponse.group.isEmpty) {
          context
              .read<GroupPageBloc>()
              .add(GroupDiscoverEvent(groupResponse.group));
          context
              .read<GroupPageBloc>()
              .add(HasReachedMaxGroupDiscoverEvent(true));
          context
              .read<GroupPageBloc>()
              .add(StatusGroupDiscoverEvent(Status.success));
          return;
        }

        if (page == 0) {
          context
              .read<GroupPageBloc>()
              .add(GroupDiscoverEvent(groupResponse.group));
        } else {
          List<Group> currentList =
              BlocProvider.of<GroupPageBloc>(context).state.groupDiscover;
          List<Group> updatedNewsList = List.of(currentList)
            ..addAll(groupResponse.group);
          context
              .read<GroupPageBloc>()
              .add(GroupDiscoverEvent(updatedNewsList));
        }
        if (groupResponse.group.length < pageSize) {
          context
              .read<GroupPageBloc>()
              .add(HasReachedMaxGroupDiscoverEvent(true));
        }
        context
            .read<GroupPageBloc>()
            .add(StatusGroupDiscoverEvent(Status.success));
      } else {}
    } catch (error, stacktrace) {}
  }

  Future<void> handleLoadGroupJoinedData(int page) async {
    if (page == 0) {
      context.read<GroupPageBloc>().add(HasReachedMaxGroupJoinedEvent(false));
      context.read<GroupPageBloc>().add(IndexGroupJoinedEvent(1));
    } else {
      if (BlocProvider.of<GroupPageBloc>(context)
          .state
          .hasReachedMaxGroupJoined) {
        return;
      }
      context.read<GroupPageBloc>().add(IndexGroupJoinedEvent(
          BlocProvider.of<GroupPageBloc>(context).state.indexGroupJoined + 1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups';
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
        var groupResponse = GroupResponse.fromJson(jsonMap);
        if (groupResponse.group.isEmpty) {
          context
              .read<GroupPageBloc>()
              .add(GroupJoinedEvent(groupResponse.group));
          context
              .read<GroupPageBloc>()
              .add(HasReachedMaxGroupJoinedEvent(true));
          context
              .read<GroupPageBloc>()
              .add(StatusGroupJoinedEvent(Status.success));
          return;
        }

        if (page == 0) {
          context
              .read<GroupPageBloc>()
              .add(GroupJoinedEvent(groupResponse.group));
        } else {
          List<Group> currentList =
              BlocProvider.of<GroupPageBloc>(context).state.groupJoined;
          List<Group> updatedNewsList = List.of(currentList)
            ..addAll(groupResponse.group);
          context.read<GroupPageBloc>().add(GroupJoinedEvent(updatedNewsList));
        }
        if (groupResponse.group.length < pageSize) {
          context
              .read<GroupPageBloc>()
              .add(HasReachedMaxGroupJoinedEvent(true));
        }
        context
            .read<GroupPageBloc>()
            .add(StatusGroupJoinedEvent(Status.success));
      } else {}
    } catch (error, stacktrace) {}
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
        GroupPageController(context: context).handleLoadGroupDiscoverData(0);
      } else {
        // Handle other status codes if needed
      }
    } catch (error, stacktrace) {
      // Handle errors
    }
  }
}
