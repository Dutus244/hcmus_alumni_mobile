import 'dart:convert'; // Import the 'dart:convert' library

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcmus_alumni_mobile/model/event.dart';
import 'package:hcmus_alumni_mobile/model/news_response.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/bloc/news_event_page_events.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/bloc/news_event_page_states.dart';

import '../../global.dart';
import 'package:http/http.dart' as http;

import '../../model/event_response.dart';
import '../../model/news.dart';
import 'bloc/news_event_page_blocs.dart';

class NewsEventPageController {
  final BuildContext context;

  const NewsEventPageController({required this.context});

  Future<void> handleLoadNewsData(int page) async {
    if (BlocProvider.of<NewsEventPageBloc>(context).state.hasReachedMaxNews) {
      return;
    }
    context.read<NewsEventPageBloc>().add(IndexNewsEvent(
        BlocProvider.of<NewsEventPageBloc>(context).state.indexNews + 1));
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/news';
    var pageSize = 5;

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };
    await Future.delayed(Duration(seconds: 3));
    try {
      var url = Uri.parse('$apiUrl$endpoint?page=$page&pageSize=$pageSize');

      // Specify UTF-8 encoding for decoding response
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        // Convert the JSON string to a Map
        var jsonMap = json.decode(responseBody);

        // Pass the Map to the fromJson method
        var newsResponse = NewsResponse.fromJson(jsonMap);

        if (newsResponse.news.isEmpty) {
          context.read<NewsEventPageBloc>().add(HasReachedMaxNewsEvent(true));
          return;
        }
        List<News> currentList =
            BlocProvider.of<NewsEventPageBloc>(context).state.news;

        // Create a new list by adding newsResponse.news to the existing list
        List<News> updatedNewsList = List.of(currentList)
          ..addAll(newsResponse.news);

        context.read<NewsEventPageBloc>().add(NewsEvent(updatedNewsList));
        context.read<NewsEventPageBloc>().add(StatusNewsEvent(Status.success));
      } else {
        // Handle other status codes if needed
      }
    } catch (error, stacktrace) {
      // Handle errors
    }
  }

  Future<void> handleLoadEventData(int page) async {
    if (BlocProvider.of<NewsEventPageBloc>(context).state.hasReachedMaxEvent) {
      return;
    }
    context.read<NewsEventPageBloc>().add(IndexEventEvent(
        BlocProvider.of<NewsEventPageBloc>(context).state.indexEvent + 1));
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/events';
    var pageSize = 5;

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };
    await Future.delayed(Duration(seconds: 3));
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

        if (eventResponse.event.isEmpty) {
          context.read<NewsEventPageBloc>().add(HasReachedMaxEventEvent(true));
          return;
        }
        List<Event> currentList =
            BlocProvider.of<NewsEventPageBloc>(context).state.event;

        // Create a new list by adding newsResponse.news to the existing list
        List<Event> updatedEventList = List.of(currentList)
          ..addAll(eventResponse.event);

        context.read<NewsEventPageBloc>().add(EventEvent(updatedEventList));
        context.read<NewsEventPageBloc>().add(StatusEventEvent(Status.success));
      } else {
        // Handle other status codes if needed
      }
    } catch (error, stacktrace) {
      // Handle errors
    }
  }
}
