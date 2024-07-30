import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
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
        toastInfo(msg: translate('error_get_info_group'));
      }
    } catch (error) {
      toastInfo(msg: translate('error_get_info_group'));
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
        toastInfo(msg: translate('error_exit_group'));
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: translate('error_exit_group'));
    }
  }

  Future<void> handleDeleteGroup(String id) async {
    final shouldDelte = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(translate('delete_group')),
        content: Text(translate('delete_group_question')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(translate('cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(translate('delete')),
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
          toastInfo(msg: translate('error_delete_group'));
        }
      } catch (error) {
        // Handle errors
        toastInfo(msg: translate('error_delete_group'));
      }
    }
    return shouldDelte ?? false;
  }
}