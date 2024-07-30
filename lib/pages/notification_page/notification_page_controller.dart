import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/notification_response.dart';
import '../../model/notification.dart';
import 'bloc/notification_page_blocs.dart';
import 'bloc/notification_page_events.dart';
import 'bloc/notification_page_states.dart';

class NotificationPageController {
  final BuildContext context;

  const NotificationPageController({required this.context});

  Future<void> handleLoadNotificationsData(int page) async {
    if (page == 0) {
      context
          .read<NotificationPageBloc>()
          .add(HasReachedMaxNotificationEvent(false));
      context.read<NotificationPageBloc>().add(IndexNotificationEvent(1));
    } else {
      if (BlocProvider.of<NotificationPageBloc>(context)
          .state
          .hasReachedMaxNotification) {
        return;
      }
      context.read<NotificationPageBloc>().add(IndexNotificationEvent(
          BlocProvider.of<NotificationPageBloc>(context)
                  .state
                  .indexNotification +
              1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/notification';
    var pageSize = 10;
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
        var notificationResponse = NotificationResponse.fromJson(jsonMap);

        if (notificationResponse.notifications.isEmpty) {
          if (page == 0) {
            context
                .read<NotificationPageBloc>()
                .add(NotificationsEvent(notificationResponse.notifications));
          }
          context
              .read<NotificationPageBloc>()
              .add(HasReachedMaxNotificationEvent(true));
          context
              .read<NotificationPageBloc>()
              .add(StatusNotificationEvent(Status.success));
          return;
        }

        if (page == 0) {
          context
              .read<NotificationPageBloc>()
              .add(NotificationsEvent(notificationResponse.notifications));
        } else {
          List<Notifications> currentList =
              BlocProvider.of<NotificationPageBloc>(context)
                  .state
                  .notifications;
          List<Notifications> updatedEventList = List.of(currentList)
            ..addAll(notificationResponse.notifications);
          context
              .read<NotificationPageBloc>()
              .add(NotificationsEvent(updatedEventList));
        }
        if (notificationResponse.notifications.length < pageSize) {
          context
              .read<NotificationPageBloc>()
              .add(HasReachedMaxNotificationEvent(true));
        }
        context
            .read<NotificationPageBloc>()
            .add(StatusNotificationEvent(Status.success));
      } else {
        toastInfo(msg: translate('error_get_notification'));
      }
    } catch (error) {
      if (error.toString() != "Looking up a deactivated widget's ancestor is unsafe.\nAt this point the state of the widget's element tree is no longer stable.\nTo safely refer to a widget's ancestor in its dispose() method, save a reference to the ancestor by calling dependOnInheritedWidgetOfExactType() in the widget's didChangeDependencies() method.") {
        toastInfo(msg: translate('error_get_notification'));
      }
    }
  }

  Future<void> handleSeenNotification(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/notification/$id';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.put(url, headers: headers);

      if (response.statusCode == 200) {
        handleLoadNotificationsData(0);
      } else {
        // Handle other status codes if needed
        toastInfo(msg: translate('error_seen_notification'));
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: translate('error_seen_notification'));
    }
  }
}
