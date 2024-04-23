import 'dart:convert'; // Import the 'dart:convert' library

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcmus_alumni_mobile/model/news_response.dart';

import '../../global.dart';
import 'package:http/http.dart' as http;

import '../../model/event_response.dart';
import 'bloc/home_page_blocs.dart';
import 'bloc/home_page_events.dart';

class HomePageController {
  final BuildContext context;

  const HomePageController({required this.context});

  Future<void> handleLoadEventData() async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/events';
    var page = '0';
    var pageSize = '6';

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
        context.read<HomePageBloc>().add(EventEvent(eventResponse.event));
      } else {
        // Handle other status codes if needed
      }
    } catch (error, stacktrace) {
      // Handle errors
    }
  }

  Future<void> handleLoadNewsData() async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/news/hot';
    var param = '6';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint?limit=$param');

      // Specify UTF-8 encoding for decoding response
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        // Convert the JSON string to a Map
        var jsonMap = json.decode(responseBody);

        // Pass the Map to the fromJson method
        var newsResponse = NewsResponse.fromJson(jsonMap);
        context.read<HomePageBloc>().add(NewsEvent(newsResponse.news));
      } else {
        // Handle other status codes if needed
      }
    } catch (error, stacktrace) {
      // Handle errors
    }
  }
}
