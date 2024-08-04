import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/model/member_response.dart';
import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'package:http/http.dart' as http;

import 'bloc/group_info_blocs.dart';
import 'bloc/group_info_events.dart';

class GroupInfoController {
  final BuildContext context;

  const GroupInfoController({required this.context});

  Future<void> handleGetMember(String id, int page) async {
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

        context.read<GroupInfoBloc>().add(MembersEvent(memberResponse.members));
      } else {
        toastInfo(msg: translate('error_get_member'));
      }
    } catch (error) {
      // toastInfo(msg: translate('error_get_member'));
    }
  }

  Future<void> handleGetAdmin(String id, int page) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$id/members';
    var pageSize = 50;
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          '$apiUrl$endpoint?page=$page&pageSize=$pageSize&role=CREATOR');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var memberResponse = MemberResponse.fromJson(jsonMap);

        var url = Uri.parse(
            '$apiUrl$endpoint?page=$page&pageSize=$pageSize&role=ADMIN');
        response = await http.get(url, headers: headers);
        responseBody = utf8.decode(response.bodyBytes);
        if (response.statusCode == 200) {
          jsonMap = json.decode(responseBody);
          memberResponse.members.addAll(MemberResponse.fromJson(jsonMap).members);

          context.read<GroupInfoBloc>().add(AdminsEvent(memberResponse.members));
        }
      } else {
        toastInfo(msg: translate('error_get_member'));
      }
    } catch (error) {
      // toastInfo(msg: translate('error_get_member'));
    }
  }
}
