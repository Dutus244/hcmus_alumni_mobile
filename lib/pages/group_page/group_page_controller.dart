import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../common/widgets/flutter_toast.dart';
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
      var url = Uri.parse('$apiUrl$endpoint?page=$page&pageSize=$pageSize&isJoined=false');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var groupResponse = GroupResponse.fromJson(jsonMap);
        if (groupResponse.groups.isEmpty) {
          if (page == 0) {
            context
                .read<GroupPageBloc>()
                .add(GroupDiscoversEvent(groupResponse.groups));
          }
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
              .add(GroupDiscoversEvent(groupResponse.groups));
        } else {
          List<Group> currentList =
              BlocProvider.of<GroupPageBloc>(context).state.groupDiscovers;
          List<Group> updatedNewsList = List.of(currentList)
            ..addAll(groupResponse.groups);
          context
              .read<GroupPageBloc>()
              .add(GroupDiscoversEvent(updatedNewsList));
        }
        if (groupResponse.groups.length < pageSize) {
          context
              .read<GroupPageBloc>()
              .add(HasReachedMaxGroupDiscoverEvent(true));
        }
        context
            .read<GroupPageBloc>()
            .add(StatusGroupDiscoverEvent(Status.success));
      } else {
        toastInfo(msg: translate('error_get_group'));
      }
    } catch (error) {
      toastInfo(msg: translate('error_get_group'));
    }
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
      var url = Uri.parse('$apiUrl$endpoint?page=$page&pageSize=$pageSize&isJoined=true');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var groupResponse = GroupResponse.fromJson(jsonMap);
        if (groupResponse.groups.isEmpty) {
          context
              .read<GroupPageBloc>()
              .add(GroupJoinedsEvent(groupResponse.groups));
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
              .add(GroupJoinedsEvent(groupResponse.groups));
        } else {
          List<Group> currentList =
              BlocProvider.of<GroupPageBloc>(context).state.groupJoineds;
          List<Group> updatedNewsList = List.of(currentList)
            ..addAll(groupResponse.groups);
          context.read<GroupPageBloc>().add(GroupJoinedsEvent(updatedNewsList));
        }
        if (groupResponse.groups.length < pageSize) {
          context
              .read<GroupPageBloc>()
              .add(HasReachedMaxGroupJoinedEvent(true));
        }
        context
            .read<GroupPageBloc>()
            .add(StatusGroupJoinedEvent(Status.success));
      } else {
        toastInfo(msg: translate('error_get_group'));
      }
    } catch (error) {
      toastInfo(msg: translate('error_get_group'));
    }
  }

  Future<void> handleRequestJoinGroup(Group group) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/${group.id}/requests';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.post(url, headers: headers);
      if (response.statusCode == 201) {
        if (group.privacy == 'PUBLIC') {
          await Navigator.pushNamed(
            context,
            "/groupDetail",
            arguments: {
              "id": group.id,
            },
          );
          GroupPageController(context: context).handleLoadGroupDiscoverData(0);
          GroupPageController(context: context).handleLoadGroupJoinedData(0);
        }
        else {
          GroupPageController(context: context).handleLoadGroupDiscoverData(0);
        }
      } else {
        // Handle other status codes if needed
        toastInfo(msg: translate('error_join_group'));
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: translate('error_join_group'));
    }
  }
}
