// import 'dart:async';
// import 'dart:convert';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:hcmus_alumni_mobile/main.dart';
// import 'package:http/http.dart' as http;
//
// import '../../global.dart';
//
// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   print('Title: ${message.notification?.title}');
//   print('Body: ${message.notification?.body}');
//   print('Payload: ${message.data}');
// }
//
// class FirebaseService {
//   final _firebaseMessaging = FirebaseMessaging.instance;
//
//   final _androidChannel = const AndroidNotificationChannel(
//       'high_importance_channel', 'High Importance Notifications',
//       description: "This channel is used for importance notification",
//       importance: Importance.defaultImportance);
//   final _localNotifications = FlutterLocalNotificationsPlugin();
//
//   Future<void> handleMessage(RemoteMessage? message) async {
//     if (message == null) return;
//     var data = jsonDecode(message.data["body"]);
//     var apiUrl = dotenv.env['API_URL'];
//     var endpoint = '/notification/${data["id"]}';
//
//     var token = Global.storageService.getUserAuthToken();
//
//     var headers = <String, String>{
//       'Authorization': 'Bearer $token',
//       "Content-Type": "application/json"
//     };
//
//     try {
//       var url = Uri.parse('$apiUrl$endpoint');
//       await http.put(url, headers: headers);
//     } catch (error) {}
//     switch (data["entityTable"]) {
//       case "request_friend":
//         navigatorKey.currentState?.pushNamedAndRemoveUntil(
//             "/applicationPage", (route) => false,
//             arguments: {"route": 4});
//         break;
//       case "comment_event":
//         navigatorKey.currentState?.pushNamed(
//           "/eventDetail",
//           arguments: {"id": data["parentId"]},
//         );
//         break;
//       case "news_event":
//         navigatorKey.currentState?.pushNamed(
//           "/newsDetail",
//           arguments: {"id": data["parentId"]},
//         );
//         break;
//       case "group":
//         navigatorKey.currentState?.pushNamed(
//           "/groupDetail",
//           arguments: {"id": data["entityId"]},
//         );
//         break;
//       case "request_join_group":
//         switch (data["notificationType"]) {
//           case "CREATE":
//             navigatorKey.currentState?.pushNamed(
//               "/groupMemberApprove",
//               arguments: {"groupId": data["entityId"]},
//             );
//             break;
//           case "UPDATE":
//             navigatorKey.currentState?.pushNamed(
//               "/groupDetail",
//               arguments: {"id": data["entityId"]},
//             );
//             break;
//         }
//       case "interact_post_group":
//         navigatorKey.currentState?.pushNamed(
//           "/postGroupDetail",
//           arguments: {"id": data["entityId"]},
//         );
//         break;
//       case "comment_post_group":
//         navigatorKey.currentState?.pushNamed(
//           "/postGroupDetail",
//           arguments: {"id": data["parentId"]},
//         );
//         break;
//       case "interact_post_advise":
//         navigatorKey.currentState?.pushNamed(
//           "/postAdviseDetail",
//           arguments: {"id": data["entityId"]},
//         );
//         break;
//       case "comment_post_advise":
//         navigatorKey.currentState?.pushNamed(
//           "/postAdviseDetail",
//           arguments: {"id": data["parentId"]},
//         );
//         break;
//     }
//   }
//
//   Future initLocalNotifications() async {
//     const iOS = DarwinInitializationSettings();
//     const android = AndroidInitializationSettings('drawable/ic_launcher');
//     const settings = InitializationSettings(android: android, iOS: iOS);
//     await _localNotifications.initialize(
//       settings,
//       onDidReceiveNotificationResponse:
//           (NotificationResponse notificationResponse) async {
//         final payload = notificationResponse.payload;
//         if (payload != null) {
//           final message = RemoteMessage.fromMap(jsonDecode(payload));
//           handleMessage(message);
//         }
//       },
//     );
//     final platform = _localNotifications.resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>();
//     await platform?.createNotificationChannel(_androidChannel);
//   }
//
//   Future initPushNotifications() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//     FirebaseMessaging.onMessage.listen((message) {
//       final notification = message.notification;
//       if (notification == null) return;
//       _localNotifications.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//             android: AndroidNotificationDetails(
//                 _androidChannel.id, _androidChannel.name,
//                 icon: '@drawable/ic_launcher')),
//         payload: jsonEncode(message.toMap()),
//       );
//     });
//   }
//
//   Future<void> initNotifications() async {
//     await _firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//     initPushNotifications();
//     initLocalNotifications();
//   }
//
//   Future<String?> getFcmToken() async {
//     try {
//       final fcmToken = await _firebaseMessaging.getToken();
//       print('token: $fcmToken');
//       return fcmToken;
//     } catch (e) {
//       return null;
//     }
//   }
// }


import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../global.dart';
import '../../main.dart';
import 'package:http/http.dart' as http;

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

  Future<void> handleMessage(BuildContext context, RemoteMessage message) async {
    print('In handleMesssage function');
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
          arguments: {"inboxId": int.parse(data["parentId"]), "name": message.notification?.title},
        );
        break;
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
        message.notification!.android!.channelId.toString(),
        message.notification!.android!.channelId.toString(),
        importance: Importance.max,
        showBadge: true,
        playSound:true
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        androidNotificationChannel.id.toString(),
        androidNotificationChannel.name.toString(),
        channelDescription: 'Flutter Notifications',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        ticker: 'ticker',
        sound: androidNotificationChannel.sound
    );

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(0,
          message.notification!.title.toString(),
          message.notification!.body.toString(), notificationDetails);
    });


  }

  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }


}
