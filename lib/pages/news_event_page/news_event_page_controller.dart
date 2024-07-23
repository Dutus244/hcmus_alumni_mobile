import 'dart:convert'; // Import the 'dart:convert' library

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/model/event.dart';
import 'package:hcmus_alumni_mobile/model/news_response.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/bloc/news_event_page_events.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/bloc/news_event_page_states.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'package:http/http.dart' as http;

import '../../model/event_response.dart';
import '../../model/news.dart';
import 'bloc/news_event_page_blocs.dart';

class NewsEventPageController {
  final BuildContext context;

  const NewsEventPageController({required this.context});

  Future<void> handleLoadNewsData(int page) async {
    if (page == 0) {
      context.read<NewsEventPageBloc>().add(HasReachedMaxNewsEvent(false));
      context.read<NewsEventPageBloc>().add(IndexNewsEvent(1));
    } else {
      if (BlocProvider.of<NewsEventPageBloc>(context).state.hasReachedMaxNews) {
        return;
      }
      context.read<NewsEventPageBloc>().add(IndexNewsEvent(
          BlocProvider.of<NewsEventPageBloc>(context).state.indexNews + 1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/news';
    var pageSize = 5;
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
        var newsResponse = NewsResponse.fromJson(jsonMap);

        if (newsResponse.news.isEmpty) {
          if (page == 0) {
            context.read<NewsEventPageBloc>().add(NewsEvent(newsResponse.news));
          }
          context.read<NewsEventPageBloc>().add(HasReachedMaxNewsEvent(true));
          context
              .read<NewsEventPageBloc>()
              .add(StatusEventEvent(Status.success));
          return;
        }

        if (page == 0) {
          context.read<NewsEventPageBloc>().add(NewsEvent(newsResponse.news));
        } else {
          List<News> currentList =
              BlocProvider.of<NewsEventPageBloc>(context).state.news;
          List<News> updatedNewsList = List.of(currentList)
            ..addAll(newsResponse.news);
          context.read<NewsEventPageBloc>().add(NewsEvent(updatedNewsList));
        }
        if (newsResponse.news.length < pageSize) {
          context.read<NewsEventPageBloc>().add(HasReachedMaxNewsEvent(true));
        }
        context.read<NewsEventPageBloc>().add(StatusNewsEvent(Status.success));
      } else {
        toastInfo(msg: translate('error_get_news'));
      }
    } catch (error) {
      if (error.toString() != "Looking up a deactivated widget's ancestor is unsafe.\nAt this point the state of the widget's element tree is no longer stable.\nTo safely refer to a widget's ancestor in its dispose() method, save a reference to the ancestor by calling dependOnInheritedWidgetOfExactType() in the widget's didChangeDependencies() method.") {
        toastInfo(msg: translate('error_get_news'));
      }
    }
  }

  Future<void> handleLoadEventData(int page) async {
    if (page == 0) {
      context.read<NewsEventPageBloc>().add(HasReachedMaxEventEvent(false));
      context.read<NewsEventPageBloc>().add(IndexEventEvent(1));
    } else {
      if (BlocProvider.of<NewsEventPageBloc>(context)
          .state
          .hasReachedMaxEvent) {
        return;
      }
      context.read<NewsEventPageBloc>().add(IndexEventEvent(
          BlocProvider.of<NewsEventPageBloc>(context).state.indexEvent + 1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/events';
    var pageSize = 5;
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse('$apiUrl$endpoint?page=$page&pageSize=$pageSize&order=asc');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var eventResponse = EventResponse.fromJson(jsonMap);
        print(eventResponse.events.length);

        if (eventResponse.events.isEmpty) {
          if (page == 0) {
            context
                .read<NewsEventPageBloc>()
                .add(EventsEvent(eventResponse.events));
          }
          context.read<NewsEventPageBloc>().add(HasReachedMaxEventEvent(true));
          context
              .read<NewsEventPageBloc>()
              .add(StatusEventEvent(Status.success));
          return;
        }

        if (page == 0) {
          context
              .read<NewsEventPageBloc>()
              .add(EventsEvent(eventResponse.events));
        } else {
          List<Event> currentList =
              BlocProvider.of<NewsEventPageBloc>(context).state.events;
          List<Event> updatedEventList = List.of(currentList)
            ..addAll(eventResponse.events);
          context.read<NewsEventPageBloc>().add(EventsEvent(updatedEventList));
        }
        if (eventResponse.events.length < pageSize) {
          context.read<NewsEventPageBloc>().add(HasReachedMaxEventEvent(true));
        }
        context.read<NewsEventPageBloc>().add(StatusEventEvent(Status.success));
      } else {
        toastInfo(msg: translate('error_get_event'));
      }
    } catch (error) {
      if (error.toString() != "Looking up a deactivated widget's ancestor is unsafe.\nAt this point the state of the widget's element tree is no longer stable.\nTo safely refer to a widget's ancestor in its dispose() method, save a reference to the ancestor by calling dependOnInheritedWidgetOfExactType() in the widget's didChangeDependencies() method.") {
        toastInfo(msg: translate('error_get_event'));
      }
    }
  }
}
