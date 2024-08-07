import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/hall_of_fame.dart';
import 'bloc/hof_detail_blocs.dart';
import 'bloc/hof_detail_events.dart';

class HofDetailController {
  final BuildContext context;

  const HofDetailController({required this.context});

  Future<void> handleGetHof(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/hof/$id';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        // Convert the JSON string to a Map
        var jsonMap = json.decode(responseBody);
        // Pass the Map to the fromJson method
        var hallOfFame = HallOfFame.fromJson(jsonMap);
        context.read<HofDetailBloc>().add(HofEvent(hallOfFame));
      } else {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        int errorCode = jsonMap['error']['code'];
        if (errorCode == 30300) {
          toastInfo(msg: translate('no_hof'));
          return;
        }
      }
    } catch (error) {
      // Handle errors
      // toastInfo(msg: translate('error_get_hof'));
    }
  }
}
