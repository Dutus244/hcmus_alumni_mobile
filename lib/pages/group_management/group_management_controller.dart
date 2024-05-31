import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
      } else {}
    } catch (error) {}
  }

  Future<void> handleExitGroup(String id, int secondRoute) async {
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
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/applicationPage", (route) => false,
            arguments: {"route": 3, "secondRoute": secondRoute});
      } else {
        // Handle other status codes if needed
      }
    } catch (error) {
      // Handle errors
    }
  }

  Future<void> handleDeleteGroup(String id, int secondRoute) async {
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
          Navigator.of(context).pushNamedAndRemoveUntil(
              "/applicationPage", (route) => false,
              arguments: {"route": 3, "secondRoute": secondRoute});
        } else {
          // Handle other status codes if needed
        }
      } catch (error) {
        // Handle errors
      }
    }
    return shouldDelte ?? false;
  }
}