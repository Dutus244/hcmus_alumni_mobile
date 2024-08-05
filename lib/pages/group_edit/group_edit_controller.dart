import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:io';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/group.dart';
import 'bloc/group_edit_blocs.dart';
import 'bloc/group_edit_events.dart';

class GroupEditController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  GroupEditController({required this.context});

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
        context.read<GroupEditBloc>().add(GroupEditResetEvent());
        context.read<GroupEditBloc>().add(NameEvent(group.name));
        context.read<GroupEditBloc>().add(DescriptionEvent(group.description));
        context.read<GroupEditBloc>().add(PrivacyEvent(group.privacy == 'PUBLIC' ? 0 : 1));
        context.read<GroupEditBloc>().add(NetworkPictureEvent(group.coverUrl ?? ''));
      } else {
        toastInfo(msg: translate('error_get_info_group'));
      }
    } catch (error) {
      // toastInfo(msg: translate('error_get_info_group'));
    }
  }

  Future<void> handleEditGroup(Group group) async {
    context.read<GroupEditBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
    final state = context.read<GroupEditBloc>().state;
    String name = state.name;
    String description = state.description;
    String privacy = state.privacy == 0 ? 'PUBLIC' : 'PRIVATE';
    List<File> pictures = state.pictures;

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups/${group.id}';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var request = http.MultipartRequest('PUT', Uri.parse('$apiUrl$endpoint'));
    request.headers.addAll(headers);
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['privacy'] = privacy;

    for (var i = 0; i < pictures.length; i++) {
      request.files.add(
        http.MultipartFile(
          'cover',
          pictures[i].readAsBytes().asStream(),
          pictures[i].lengthSync(),
          filename: i.toString(),
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    }

    try {
      // Send the request
      var streamedResponse = await request.send();

      // Convert the streamed response to a regular HTTP response
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        context.read<GroupEditBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: 'Sửa nhóm thành công');
        Navigator.pop(context);
      } else {
        context.read<GroupEditBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_edit_group'));
      }
    } catch (e) {
      // Exception occurred
      // toastInfo(msg: translate('error_edit_group'));
      hideLoadingIndicator();
    }
  }
}