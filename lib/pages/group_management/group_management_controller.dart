import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'package:http/http.dart' as http;

import '../../model/group.dart';
import 'bloc/group_management_blocs.dart';
import 'bloc/group_management_events.dart';

class GroupManagementController {
  final BuildContext context;

  const GroupManagementController({required this.context});

  Future<void> handleGetGroup(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$id';
    var token = Global.storageService.getUserAuthToken();
    var headers = <String, String>{
      'Authorization': 'Bearer $token',
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var group = Group.fromJson(jsonMap);
        context.read< GroupManagementBloc>().add(GroupEvent(group));
      } else {
        toastInfo(msg: "Có lỗi xả ra khi lấy thông tin nhóm");
      }
    } catch (error) {
      toastInfo(msg: "Có lỗi xả ra khi lấy thông tin nhóm");
    }
  }

  Future<void> handleExitGroup(String id) async {
    String userId = '';
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/$id/members/$userId';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        // Handle other status codes if needed
        toastInfo(msg: "Có lỗi xả ra khi thoát nhóm");
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: "Có lỗi xả ra khi thoát nhóm");
    }
  }

  Future<void> handleDeleteGroup(String id) async {
    final shouldDelte = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Xoá nhóm'),
        content: Text('Bạn có muốn xoá nhóm này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Huỷ'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Xoá'),
          ),
        ],
      ),
    );
    if (shouldDelte != null && shouldDelte) {
      var apiUrl = dotenv.env['API_URL'];
      var endpoint = '/groups/$id';

      var token = Global.storageService.getUserAuthToken();

      var headers = <String, String>{
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      };

      try {
        var url = Uri.parse('$apiUrl$endpoint');

        var response = await http.delete(url, headers: headers);
        if (response.statusCode == 200) {
          Navigator.pop(context);
        } else {
          // Handle other status codes if needed
          toastInfo(msg: "Có lỗi xả ra khi xoá nhóm");
        }
      } catch (error) {
        // Handle errors
        toastInfo(msg: "Có lỗi xả ra khi xoá nhóm");
      }
    }
    return shouldDelte ?? false;
  }
}