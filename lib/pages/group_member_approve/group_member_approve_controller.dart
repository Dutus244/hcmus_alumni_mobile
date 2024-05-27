import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcmus_alumni_mobile/model/request_group.dart';
import 'package:hcmus_alumni_mobile/model/request_group_response.dart';

import 'bloc/group_member_approve_blocs.dart';
import 'bloc/group_member_approve_events.dart';
import 'bloc/group_member_approve_states.dart';
import '../../global.dart';
import 'package:http/http.dart' as http;

class GroupMemberApproveController {
  final BuildContext context;

  const GroupMemberApproveController({required this.context});

  Future<void> handleGetMember(String id, int page) async {
    if (page == 0) {
      context
          .read<GroupMemberApproveBloc>()
          .add(HasReachedMaxRequestEvent(false));
      context.read<GroupMemberApproveBloc>().add(IndexRequestEvent(1));
    } else {
      if (BlocProvider.of<GroupMemberApproveBloc>(context)
          .state
          .hasReachedMaxRequest) {
        return;
      }
      context.read<GroupMemberApproveBloc>().add(IndexRequestEvent(
          BlocProvider.of<GroupMemberApproveBloc>(context).state.indexRequest +
              1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$id/requests';
    var pageSize = 10;
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          '$apiUrl$endpoint?page=$page&pageSize=$pageSize&role=MEMBER');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var requestResponse = RequestGroupResponse.fromJson(jsonMap);
        if (requestResponse.request.isEmpty) {
          if (page == 0) {
            context
                .read<GroupMemberApproveBloc>()
                .add(RequestEvent(requestResponse.request));
          }
          context
              .read<GroupMemberApproveBloc>()
              .add(HasReachedMaxRequestEvent(true));
          context
              .read<GroupMemberApproveBloc>()
              .add(StatusEvent(Status.success));
          return;
        }

        if (page == 0) {
          context
              .read<GroupMemberApproveBloc>()
              .add(RequestEvent(requestResponse.request));
        } else {
          List<RequestGroup> currentList =
              BlocProvider.of<GroupMemberApproveBloc>(context).state.request;
          List<RequestGroup> updatedNewsList = List.of(currentList)
            ..addAll(requestResponse.request);
          context
              .read<GroupMemberApproveBloc>()
              .add(RequestEvent(updatedNewsList));
        }
        if (requestResponse.request.length < pageSize) {
          context
              .read<GroupMemberApproveBloc>()
              .add(HasReachedMaxRequestEvent(true));
        }
        context.read<GroupMemberApproveBloc>().add(StatusEvent(Status.success));
      } else {}
    } catch (error, stacktrace) {}
  }

  Future<void> handleApprovedRequest(String groupId, String userId) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$groupId/requests/$userId';
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
    };

    try {
      var url = Uri.parse(
          '$apiUrl$endpoint?status=APPROVED');
      var response = await http.put(url, headers: headers);
      if (response.statusCode == 200) {
        GroupMemberApproveController(context: context).handleGetMember(groupId, 0);
      }
    } catch (error, stacktrace) {}
  }

  Future<void> handleDeneidRequest(String groupId, String userId) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$groupId/requests/$userId';
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
    };

    try {
      var url = Uri.parse(
          '$apiUrl$endpoint?status=DENIED');
      var response = await http.put(url, headers: headers);
      if (response.statusCode == 200) {
        GroupMemberApproveController(context: context).handleGetMember(groupId, 0);
      }
    } catch (error, stacktrace) {}
  }
}
