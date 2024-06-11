import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

  Future<void> handleLoadEventsData(int page) async {
    if (page == 0) {
      context.read<NotificationPageBloc>().add(HasReachedMaxNotificationEvent(false));
      context.read<NotificationPageBloc>().add(IndexNotificationEvent(1));
    } else {
      if (BlocProvider.of<NotificationPageBloc>(context)
          .state
          .hasReachedMaxNotification) {
        return;
      }
      context.read<NotificationPageBloc>().add(IndexNotificationEvent(
          BlocProvider.of<NotificationPageBloc>(context).state.indexNotification + 1));
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
        var notificationResponse = NotificationResponse.fromJson(jsonMap);

        if (notificationResponse.notifications.isEmpty) {
          if (page == 0) {
            context
                .read<NotificationPageBloc>()
                .add(NotificationsEvent(notificationResponse.notifications));
          }
          context.read<NotificationPageBloc>().add(HasReachedMaxNotificationEvent(true));
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
              BlocProvider.of<NotificationPageBloc>(context).state.notifications;
          List<Notifications> updatedEventList = List.of(currentList)
            ..addAll(notificationResponse.notifications);
          context.read<NotificationPageBloc>().add(NotificationsEvent(updatedEventList));
        }
        if (notificationResponse.notifications.length < pageSize) {
          context.read<NotificationPageBloc>().add(HasReachedMaxNotificationEvent(true));
        }
        context.read<NotificationPageBloc>().add(StatusNotificationEvent(Status.success));
      } else {
        toastInfo(msg: "Có lỗi xả ra khi lấy danh sách thông báo");
      }
    } catch (error) {
      toastInfo(msg: "Có lỗi xả ra khi lấy danh sách thông báo");
    }
  }
}