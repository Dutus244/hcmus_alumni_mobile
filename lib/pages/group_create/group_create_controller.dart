import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/pages/group_create/bloc/group_create_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/group_create/bloc/group_create_events.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:io';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';

class GroupCreateController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  GroupCreateController({required this.context});

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

  List<Map<String, dynamic>> convertTagsToJson(List<String> tags) {
    return tags.map((tag) => {'name': tag}).toList();
  }

  Future<void> handleCreateGroup() async {
    context.read<GroupCreateBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
    final state = context.read<GroupCreateBloc>().state;
    String name = state.name;
    String description = state.description;
    String privacy = state.privacy == 0 ? 'PUBLIC' : 'PRIVATE';
    List<File> pictures = state.pictures;
    List<String> tags = state.tags;

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/groups';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var request = http.MultipartRequest('POST', Uri.parse('$apiUrl$endpoint'));
    request.headers.addAll(headers);
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['privacy'] = privacy;
    request.fields['tags'] = convertTagsToJson(tags).toString();

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
      if (response.statusCode == 201) {
        context.read<GroupCreateBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: 'Tạo nhóm thành công');
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/applicationPage",
              (route) => false,
          arguments: {
            "route": 3,
            "secondRoute": 1,
          },
        );
      } else {
        context.read<GroupCreateBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_create_group'));
      }
    } catch (e) {
      // Exception occurred
      // toastInfo(msg: translate('error_create_group'));
      hideLoadingIndicator();
    }
  }
}
