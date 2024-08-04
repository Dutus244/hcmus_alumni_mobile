import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/model/group.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/group_response.dart';
import 'bloc/group_search_blocs.dart';
import 'bloc/group_search_events.dart';
import 'bloc/group_search_states.dart';

import 'package:http/http.dart' as http;

class GroupSearchController {
  final BuildContext context;

  const GroupSearchController({required this.context});

  Future<void> handleSearchGroup() async {
    final state = context
        .read<GroupSearchBloc>()
        .state;
    String name = state.name;
    context.read<GroupSearchBloc>().add(NameSearchEvent(name));
    await Future.delayed(Duration(milliseconds: 100));
    handleLoadGroupData(0);
  }

  Future<void> handleLoadGroupData(int page) async {
    await Future.delayed(Duration(microseconds: 500));
    if (page == 0) {
      context.read<GroupSearchBloc>().add(HasReachedMaxGroupEvent(false));
      context.read<GroupSearchBloc>().add(IndexGroupEvent(1));
    } else {
      if (BlocProvider.of<GroupSearchBloc>(context).state.hasReachedMaxGroup) {
        return;
      }
      context.read<GroupSearchBloc>().add(IndexGroupEvent(
          BlocProvider.of<GroupSearchBloc>(context).state.indexGroup + 1));
    }
    final state = context.read<GroupSearchBloc>().state;
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
        // Pass the Map to the fromJson method
        var groupResponse = GroupResponse.fromJson(jsonMap);
        if (groupResponse.groups.isEmpty) {
          if (page == 0) {
            context
                .read<GroupSearchBloc>()
                .add(GroupsEvent(groupResponse.groups));
          }
          context.read<GroupSearchBloc>().add(HasReachedMaxGroupEvent(true));
          context.read<GroupSearchBloc>().add(StatusEvent(Status.success));
          return;
        }
        if (page == 0) {
          context
              .read<GroupSearchBloc>()
              .add(GroupsEvent(groupResponse.groups));
        } else {
          List<Group> currentList =
              BlocProvider.of<GroupSearchBloc>(context).state.groups;

          // Create a new list by adding newsResponse.news to the existing list
          List<Group> updatedNewsList = List.of(currentList)
            ..addAll(groupResponse.groups);

          context.read<GroupSearchBloc>().add(GroupsEvent(updatedNewsList));
        }
        context.read<GroupSearchBloc>().add(StatusEvent(Status.success));

        if (groupResponse.groups.length < pageSize) {
          context.read<GroupSearchBloc>().add(HasReachedMaxGroupEvent(true));
        }
      } else {
        // Handle other status codes if needed
        toastInfo(msg: translate('error_get_group'));
      }
    } catch (error) {
      // Handle errors
      // toastInfo(msg: translate('error_get_group'));
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
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/groupDetail",
                (route) => false,
            arguments: {
              "id": group.id,
              "secondRoute": 1,
              "search": 1,
            },
          );
        }
        else {
          handleLoadGroupData(0);
        }
      } else {
        // Handle other status codes if needed
        toastInfo(msg: translate('error_join_group'));
      }
    } catch (error) {
      // Handle errors
      // toastInfo(msg: translate('error_join_group'));
    }
  }
}