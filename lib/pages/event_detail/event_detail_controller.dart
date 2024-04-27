import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail/bloc/event_detail_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail/bloc/event_detail_events.dart';

import '../../global.dart';
import 'package:http/http.dart' as http;

import '../../model/event_response.dart';

class EventDetailController {
  final BuildContext context;

  const EventDetailController({required this.context});

  Future<void> handleIncreaseView(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/events';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint/$id');

      var response = await http.get(url, headers: headers);
    } catch (error, stacktrace) {
      // Handle errors
    }
  }

  Future<void> handleGetRelatedEvent() async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/events';
    var pageSize = 3;
    var page = 0;

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint?page=$page&pageSize=$pageSize');

      // Specify UTF-8 encoding for decoding response
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        // Convert the JSON string to a Map
        var jsonMap = json.decode(responseBody);

        // Pass the Map to the fromJson method
        var eventResponse = EventResponse.fromJson(jsonMap);
        context.read<EventDetailBloc>().add(RelatedEventEvent(eventResponse.event));
      } else {
        // Handle other status codes if needed
      }
    } catch (error, stacktrace) {
      // Handle errors
    }
  }
}