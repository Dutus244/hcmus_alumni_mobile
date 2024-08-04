import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/model/member_response.dart';
import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'package:http/http.dart' as http;

import '../../model/member.dart';
import 'bloc/group_member_blocs.dart';
import 'bloc/group_member_events.dart';
import 'bloc/group_member_states.dart';

class GroupMemberController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  GroupMemberController({required this.context});

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

  Future<void> handleGetMember(String id, int page) async {
    if (page == 0) {
      context.read<GroupMemberBloc>().add(HasReachedMaxMemberEvent(false));
      context.read<GroupMemberBloc>().add(IndexMemberEvent(1));
    } else {
      if (BlocProvider.of<GroupMemberBloc>(context).state.hasReachedMaxMember) {
        return;
      }
      context.read<GroupMemberBloc>().add(IndexMemberEvent(
          BlocProvider.of<GroupMemberBloc>(context).state.indexMember + 1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$id/members';
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
        var memberResponse = MemberResponse.fromJson(jsonMap);
        if (memberResponse.members.isEmpty) {
          if (page == 0) {
            context
                .read<GroupMemberBloc>()
                .add(MembersEvent(memberResponse.members));
          }
          context.read<GroupMemberBloc>().add(HasReachedMaxMemberEvent(true));
          context.read<GroupMemberBloc>().add(StatusEvent(Status.success));
          return;
        }

        if (page == 0) {
          context
              .read<GroupMemberBloc>()
              .add(MembersEvent(memberResponse.members));
        } else {
          List<Member> currentList =
              BlocProvider.of<GroupMemberBloc>(context).state.members;
          List<Member> updatedNewsList = List.of(currentList)
            ..addAll(memberResponse.members);
          context.read<GroupMemberBloc>().add(MembersEvent(updatedNewsList));
        }
        if (memberResponse.members.length < pageSize) {
          context.read<GroupMemberBloc>().add(HasReachedMaxMemberEvent(true));
        }
        context.read<GroupMemberBloc>().add(StatusEvent(Status.success));
      } else {
        toastInfo(msg: translate('error_get_member'));
      }
    } catch (error) {
      // toastInfo(msg: translate('error_get_member'));
    }
  }

  Future<List<Member>> handleGetCreator(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$id/members';
    var token = Global.storageService.getUserAuthToken();
    List<Member> creatorList = const [];

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse('$apiUrl$endpoint?page=0&pageSize=1&role=CREATOR');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var memberResponse = MemberResponse.fromJson(jsonMap);
        creatorList = memberResponse.members;
      }
      else {
        toastInfo(msg: translate('error_get_member'));
      }
    } catch (error) {
      // toastInfo(msg: translate('error_get_member'));
    }
    return creatorList;
  }

  Future<void> handleGetAdmin(String id, int page) async {
    if (page == 0) {
      context.read<GroupMemberBloc>().add(HasReachedMaxAdminEvent(false));
      context.read<GroupMemberBloc>().add(IndexAdminEvent(1));
    } else {
      if (BlocProvider.of<GroupMemberBloc>(context).state.hasReachedMaxAdmin) {
        return;
      }
      context.read<GroupMemberBloc>().add(IndexAdminEvent(
          BlocProvider.of<GroupMemberBloc>(context).state.indexAdmin + 1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$id/members';
    var pageSize = 10;
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          '$apiUrl$endpoint?page=$page&pageSize=$pageSize&role=ADMIN');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var memberResponse = MemberResponse.fromJson(jsonMap);
        if (memberResponse.members.isEmpty) {
          if (page == 0) {
            List<Member> creatorList = await handleGetCreator(id);
            context.read<GroupMemberBloc>().add(AdminsEvent(creatorList));
          }
          context.read<GroupMemberBloc>().add(HasReachedMaxAdminEvent(true));
          context.read<GroupMemberBloc>().add(StatusEvent(Status.success));
          GroupMemberController(context: context).handleGetMember(id, 0);
          return;
        }

        if (page == 0) {
          List<Member> creatorList = await handleGetCreator(id);
          creatorList.addAll(memberResponse.members);
          context.read<GroupMemberBloc>().add(AdminsEvent(creatorList));
        } else {
          List<Member> currentList =
              BlocProvider.of<GroupMemberBloc>(context).state.admins;
          List<Member> updatedNewsList = List.of(currentList)
            ..addAll(memberResponse.members);
          context.read<GroupMemberBloc>().add(AdminsEvent(updatedNewsList));
        }
        if (memberResponse.members.length < pageSize) {
          context.read<GroupMemberBloc>().add(HasReachedMaxAdminEvent(true));
          GroupMemberController(context: context).handleGetMember(id, 0);
        }
        context.read<GroupMemberBloc>().add(StatusEvent(Status.success));
      } else {
        toastInfo(msg: translate('error_get_member'));
      }
    } catch (error) {
      // toastInfo(msg: translate('error_get_member'));
    }
  }

  Future<void> handleDeleteMemeber(String groupId, String userId) async {
    context.read<GroupMemberBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$groupId/members/$userId';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        await handleGetAdmin(groupId, 0);
        context.read<GroupMemberBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: 'Đã xoá thành viên thành công');
      } else {
        // Handle other status codes if needed
        context.read<GroupMemberBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_delete_member'));
      }
    } catch (error) {
      // Handle errors
      // toastInfo(msg: translate('error_delete_member'));
      hideLoadingIndicator();
    }
  }

  Future<void> handleChangeRole(String groupId, String userId, String role) async {
    context.read<GroupMemberBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$groupId/members/$userId';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    Map<String, dynamic> data = {'role': role}; // Define your JSON data
    var body = json.encode(data); // Encode the data to JSON

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        await handleGetAdmin(groupId, 0);
        context.read<GroupMemberBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: 'Đã thay đổi vai trò thành công');
      } else {
        // Handle other status codes if needed
        context.read<GroupMemberBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_change_role'));
      }
    } catch (error) {
      // Handle errors
      // toastInfo(msg: translate('error_change_role'));
      hideLoadingIndicator();
    }
  }
}
