import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:io';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/group.dart';
import 'bloc/group_edit_blocs.dart';

class GroupEditController {
  final BuildContext context;

  const GroupEditController({required this.context});

  Future<void> handleEditGroup(Group group, int secondRoute) async {
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
        Navigator.of(context).pushNamedAndRemoveUntil(
          "/groupManagement",
              (route) => false,
          arguments: {
            "group": group,
            "secondRoute": secondRoute,
          },
        );
      } else {
        toastInfo(msg: "Có lỗi xả ra khi chỉnh sửa nhóm");
      }
    } catch (e) {
      // Exception occurred
      toastInfo(msg: "Có lỗi xả ra khi chỉnh sửa nhóm");
    }
  }
}