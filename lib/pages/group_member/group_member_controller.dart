import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcmus_alumni_mobile/model/member_response.dart';
import '../../global.dart';
import 'package:http/http.dart' as http;

import '../../model/member.dart';
import 'bloc/group_member_blocs.dart';
import 'bloc/group_member_events.dart';
import 'bloc/group_member_states.dart';

class GroupMemberController {
  final BuildContext context;

  const GroupMemberController({required this.context});

  Future<void> handleGetMember(String id, int page) async {
    if (page == 0) {
      context.read<GroupMemberBloc>().add(HasReachedMaxMemberEvent(false));
      context.read<GroupMemberBloc>().add(IndexMemberEvent(1));
    } else {
      if (BlocProvider
          .of<GroupMemberBloc>(context)
          .state
          .hasReachedMaxMember) {
        return;
      }
      context.read<GroupMemberBloc>().add(IndexMemberEvent(
          BlocProvider
              .of<GroupMemberBloc>(context)
              .state
              .indexMember +
              1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$id/members';
    var pageSize = 10;
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse('$apiUrl$endpoint?page=$page&pageSize=$pageSize&role=MEMBER');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var memberResponse = MemberResponse.fromJson(jsonMap);
        if (memberResponse.member.isEmpty) {
          context
              .read<GroupMemberBloc>()
              .add(MemberEvent(memberResponse.member));
          context
              .read<GroupMemberBloc>()
              .add(HasReachedMaxMemberEvent(true));
          context
              .read<GroupMemberBloc>()
              .add(StatusEvent(Status.success));
          return;
        }

        if (page == 0) {
          context
              .read<GroupMemberBloc>()
              .add(MemberEvent(memberResponse.member));
        } else {
          List<Member> currentList =
              BlocProvider
                  .of<GroupMemberBloc>(context)
                  .state
                  .member;
          List<Member> updatedNewsList = List.of(currentList)
            ..addAll(memberResponse.member);
          context
              .read<GroupMemberBloc>()
              .add(MemberEvent(updatedNewsList));
        }
        if (memberResponse.member.length < pageSize) {
          context
              .read<GroupMemberBloc>()
              .add(HasReachedMaxMemberEvent(true));
        }
        context
            .read<GroupMemberBloc>()
            .add(StatusEvent(Status.success));
      } else {}
    } catch (error, stacktrace) {}
  }

  Future<void> handleGetAdmin(String id, int page) async {
    if (page == 0) {
      context.read<GroupMemberBloc>().add(HasReachedMaxAdminEvent(false));
      context.read<GroupMemberBloc>().add(IndexAdminEvent(1));
    } else {
      if (BlocProvider
          .of<GroupMemberBloc>(context)
          .state
          .hasReachedMaxAdmin) {
        return;
      }
      context.read<GroupMemberBloc>().add(IndexAdminEvent(
          BlocProvider
              .of<GroupMemberBloc>(context)
              .state
              .indexAdmin +
              1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$id/members';
    var pageSize = 10;
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse('$apiUrl$endpoint?page=$page&pageSize=$pageSize&role=ADMIN');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var memberResponse = MemberResponse.fromJson(jsonMap);
        if (memberResponse.member.isEmpty) {
          context
              .read<GroupMemberBloc>()
              .add(AdminEvent(memberResponse.member));
          context
              .read<GroupMemberBloc>()
              .add(HasReachedMaxAdminEvent(true));
          context
              .read<GroupMemberBloc>()
              .add(StatusEvent(Status.success));
          GroupMemberController(context: context).handleGetMember(id, 0);
          return;
        }

        if (page == 0) {
          context
              .read<GroupMemberBloc>()
              .add(AdminEvent(memberResponse.member));
        } else {
          List<Member> currentList =
              BlocProvider
                  .of<GroupMemberBloc>(context)
                  .state
                  .admin;
          List<Member> updatedNewsList = List.of(currentList)
            ..addAll(memberResponse.member);
          context
              .read<GroupMemberBloc>()
              .add(AdminEvent(updatedNewsList));
        }
        if (memberResponse.member.length < pageSize) {
          context
              .read<GroupMemberBloc>()
              .add(HasReachedMaxAdminEvent(true));
          GroupMemberController(context: context).handleGetMember(id, 0);
        }
        context
            .read<GroupMemberBloc>()
            .add(StatusEvent(Status.success));
      } else {}
    } catch (error, stacktrace) {}
  }
}