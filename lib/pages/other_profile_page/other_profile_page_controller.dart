import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/event.dart';
import '../../model/event_response.dart';
import 'bloc/other_profile_page_blocs.dart';
import 'bloc/other_profile_page_events.dart';
import 'bloc/other_profile_page_states.dart';
import 'package:http/http.dart' as http;

class OtherProfilePageController {
  final BuildContext context;

  const OtherProfilePageController({required this.context});

  Future<void> handleLoadEventsData(int page) async {
    if (page == 0) {
      context.read<OtherProfilePageBloc>().add(HasReachedMaxEventEvent(false));
      context.read<OtherProfilePageBloc>().add(IndexEventEvent(1));
    } else {
      if (BlocProvider.of<OtherProfilePageBloc>(context)
          .state
          .hasReachedMaxEvent) {
        return;
      }
      context.read<OtherProfilePageBloc>().add(IndexEventEvent(
          BlocProvider.of<OtherProfilePageBloc>(context).state.indexEvent + 1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/events';
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
        var eventResponse = EventResponse.fromJson(jsonMap);

        if (eventResponse.events.isEmpty) {
          if (page == 0) {
            context
                .read<OtherProfilePageBloc>()
                .add(EventsEvent(eventResponse.events));
          }
          context
              .read<OtherProfilePageBloc>()
              .add(HasReachedMaxEventEvent(true));
          context
              .read<OtherProfilePageBloc>()
              .add(StatusEventEvent(Status.success));
          return;
        }

        if (page == 0) {
          context
              .read<OtherProfilePageBloc>()
              .add(EventsEvent(eventResponse.events));
        } else {
          List<Event> currentList =
              BlocProvider.of<OtherProfilePageBloc>(context).state.events;
          List<Event> updatedEventList = List.of(currentList)
            ..addAll(eventResponse.events);
          context
              .read<OtherProfilePageBloc>()
              .add(EventsEvent(updatedEventList));
        }
        if (eventResponse.events.length < pageSize) {
          context
              .read<OtherProfilePageBloc>()
              .add(HasReachedMaxEventEvent(true));
        }
        context
            .read<OtherProfilePageBloc>()
            .add(StatusEventEvent(Status.success));
      } else {
        toastInfo(msg: translate('error_get_event'));
      }
    } catch (error) {
      toastInfo(msg: translate('error_get_event'));
    }
  }
}
