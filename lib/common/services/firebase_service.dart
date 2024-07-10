import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hcmus_alumni_mobile/common/services/socket_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../global.dart';
import '../../main.dart';
import 'package:http/http.dart' as http;

import '../../model/user.dart';
import '../function/handle_save_permission.dart';
import '../values/constants.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isRefreshToken() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print('TOken Refereshed');
    });
  }

  void requestNotificationPermisions() async {
    if (Platform.isIOS) {
      await messaging.requestPermission(
          alert: true,
          announcement: true,
          badge: true,
          carPlay: true,
          criticalAlert: true,
          provisional: true,
          sound: true);
    }

    NotificationSettings notificationSettings =
        await messaging.requestPermission(
            alert: true,
            announcement: true,
            badge: true,
            carPlay: true,
            criticalAlert: true,
            provisional: true,
            sound: true);

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      print('user is already granted permisions');
    } else if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user is already granted provisional permisions');
    } else {
      print('User has denied permission');
    }
  }

  // For IoS
  Future foregroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      print("Notification title: ${notification!.title}");
      print("Notification title: ${notification!.body}");
      print("Data: ${message.data.toString()}");

      // For IoS
      if (Platform.isIOS) {
        foregroundMessage();
      }

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      }
    });
  }

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitSettings = const DarwinInitializationSettings();

    var initSettings = InitializationSettings(
        android: androidInitSettings, iOS: iosInitSettings);

    await _flutterLocalNotificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (payload) {
      handleMessage(context, message);
    });
  }

  Future<void> handleMessage(
      BuildContext context, RemoteMessage message) async {
    print('In handle message function');
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
        switch (data["notificationType"]) {
          case "CREATE":
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
                "/applicationPage", (route) => false,
                arguments: {"route": 4});
            break;
          case "DELETE":
            navigatorKey.currentState
                ?.pushNamed("/otherProfilePage", arguments: {
              "id": data["entityId"],
            });
            break;
        }
      case "friend":
        navigatorKey.currentState?.pushNamed("/otherProfilePage", arguments: {
          "id": data["entityId"],
        });
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
        List<String> temp = data["parentId"].toString().split(',');
        navigatorKey.currentState?.pushNamed(
          "/postGroupDetail",
          arguments: {"id": temp[0]},
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
      case "message":
        navigatorKey.currentState?.pushNamed(
          "/chatDetail",
          arguments: {
            "inboxId": int.parse(data["parentId"]),
            "name": message.notification?.title
          },
        );
        break;
    }
  }

  Future<void> handleMessageCloseApp(
      BuildContext context, RemoteMessage message) async {
    print('In handle message function');
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
    if (Global.storageService.getUserEmail() == "") {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/splash",
        (route) => false,
      );
      return;
    }
    var url = Uri.parse('${dotenv.env['API_URL']}/auth/login');
    final map = <String, dynamic>{};
    map['email'] = Global.storageService.getUserEmail();
    map['pass'] = Global.storageService.getUserPassword();

    try {
      var response = await http.post(url, body: map);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        String jwtToken = jsonMap['jwt'];

        var url =
            Uri.parse('${dotenv.env['API_URL']}/notification/subscription');
        final token = await NotificationServices().getDeviceToken();
        var headers = <String, String>{
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json',
        };
        final body = jsonEncode({
          'token': token,
        });
        try {
          await http.post(url, body: body, headers: headers);
        } catch (error) {
          print(error);
        }

        Global.storageService.setString(AppConstants.USER_AUTH_TOKEN, jwtToken);
        Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);
        Global.storageService
            .setString(AppConstants.USER_ID, decodedToken["sub"]);
        List<String> permissions = List<String>.from(jsonMap['permissions']);
        handleSavePermission(permissions);
        socketService.connect(Global.storageService.getUserId());

        url = Uri.parse(
            '${dotenv.env['API_URL']}/user/${Global.storageService.getUserId()}/profile');
        try {
          var response = await http.get(url, headers: headers);
          var responseBody = utf8.decode(response.bodyBytes);
          print(responseBody);
          if (response.statusCode == 200) {
            var jsonMap = json.decode(responseBody);
            var user = User.fromJson(jsonMap["user"]);
            Global.storageService
                .setString(AppConstants.USER_FULL_NAME, user.fullName);
            Global.storageService
                .setString(AppConstants.USER_AVATAR_URL, user.avatarUrl);
          }
        } catch (error) {
          print(error);
        }
      } else {}
    } catch (error) {}
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      "/splash",
      (route) => false,
      arguments: {
        "entityTable": data["entityTable"],
        "notificationType": data["notificationType"],
        "entityId": data["entityId"],
        "parentId": data["parentId"],
        "name": message.notification?.title,
      },
    );
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
            message.notification!.android!.channelId.toString(),
            message.notification!.android!.channelId.toString(),
            importance: Importance.max,
            showBadge: true,
            playSound: true);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(androidNotificationChannel.id.toString(),
            androidNotificationChannel.name.toString(),
            channelDescription: 'Flutter Notifications',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            ticker: 'ticker',
            sound: androidNotificationChannel.sound);

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessageCloseApp(context, initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }
}
