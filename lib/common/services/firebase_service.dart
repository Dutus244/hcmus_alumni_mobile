import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hcmus_alumni_mobile/main.dart';
import 'package:http/http.dart' as http;

import '../../global.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: "This channel is used for importance notification",
      importance: Importance.defaultImportance);
  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> handleMessage(RemoteMessage? message) async {
    if (message == null) return;
    var data = jsonDecode(message.data["body"]);
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/notification/${data["id"]}';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint');
      await http.put(url, headers: headers);
    } catch (error) {}
    switch (data["entityTable"]) {
      case "request_friend":
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
            "/applicationPage", (route) => false,
            arguments: {"route": 4});
        break;
      case "comment_event":
        navigatorKey.currentState?.pushNamed(
          "/eventDetail",
          arguments: {"id": data["parentId"]},
        );
        break;
      case "news_event":
        navigatorKey.currentState?.pushNamed(
          "/newsDetail",
          arguments: {"id": data["parentId"]},
        );
        break;
      case "group":
        navigatorKey.currentState?.pushNamed(
          "/groupDetail",
          arguments: {"id": data["entityId"]},
        );
        break;
      case "request_join_group":
        switch (data["notificationType"]) {
          case "CREATE":
            navigatorKey.currentState?.pushNamed(
              "/groupMemberApprove",
              arguments: {"groupId": data["entityId"]},
            );
            break;
          case "UPDATE":
            navigatorKey.currentState?.pushNamed(
              "/groupDetail",
              arguments: {"id": data["entityId"]},
            );
            break;
        }
      case "interact_post_group":
        navigatorKey.currentState?.pushNamed(
          "/postGroupDetail",
          arguments: {"id": data["entityId"]},
        );
        break;
      case "comment_post_group":
        navigatorKey.currentState?.pushNamed(
          "/postGroupDetail",
          arguments: {"id": data["parentId"]},
        );
        break;
      case "interact_post_advise":
        navigatorKey.currentState?.pushNamed(
          "/postAdviseDetail",
          arguments: {"id": data["entityId"]},
        );
        break;
      case "comment_post_advise":
        navigatorKey.currentState?.pushNamed(
          "/postAdviseDetail",
          arguments: {"id": data["parentId"]},
        );
        break;
    }
  }

  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('drawable/ic_launcher');
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        final payload = notificationResponse.payload;
        if (payload != null) {
          final message = RemoteMessage.fromMap(jsonDecode(payload));
          handleMessage(message);
        }
      },
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
                _androidChannel.id, _androidChannel.name,
                icon: '@drawable/ic_launcher')),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    initPushNotifications();
    initLocalNotifications();
  }

  Future<String?> getFcmToken() async {
    try {
      final fcmToken = await _firebaseMessaging.getToken();
      print('token: $fcmToken');
      return fcmToken;
    } catch (e) {
      return null;
    }
  }
}
