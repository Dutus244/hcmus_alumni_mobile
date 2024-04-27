import 'dart:convert'; // Import the 'dart:convert' library

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcmus_alumni_mobile/model/news_response.dart';

import '../../global.dart';
import 'package:http/http.dart' as http;

import '../../model/event_response.dart';
import '../../model/hall_of_fame_response.dart';
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
      'Authorization': 'Bearer $token',
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint?page=$page&pageSize=$pageSize');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var eventResponse = EventResponse.fromJson(jsonMap);
        context.read<HomePageBloc>().add(EventEvent(eventResponse.event));
      } else {}
    } catch (error, stacktrace) {}
  }

  Future<void> handleLoadNewsData() async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/news/hot';
    var limit = '6';
    var token = Global.storageService.getUserAuthToken();
    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint?limit=$limit');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var newsResponse = NewsResponse.fromJson(jsonMap);
        context.read<HomePageBloc>().add(NewsEvent(newsResponse.news));
      } else {}
    } catch (error, stacktrace) {}
  }

  Future<void> handleLoadHallOfFameData() async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/hof';
    var page = '0';
    var pageSize = '6';
    var token = Global.storageService.getUserAuthToken();
    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint?page=$page&pageSize=$pageSize');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var hallOfFameResponse = HallOfFameResponse.fromJson(jsonMap);
        context
            .read<HomePageBloc>()
            .add(HallOfFameEvent(hallOfFameResponse.hallOfFame));
      } else {}
    } catch (error, stacktrace) {}
  }
}