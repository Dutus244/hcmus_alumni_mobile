import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hcmus_alumni_mobile/main.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  // final _androidChannel = const AndroidNotificationChannel(
  //     'high_importance_channel',
  //     'High Importance Notifications',
  //     "This channel is used for importance notification",
  //     importance: Importance.defaultImportance);
  // final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState?.pushNamed('/register');
  }

  // Future initLocalNotifications() async {
  //   const iOS = IOSInitializationSettings();
  //   const android = AndroidInitializationSettings('drawable/ic_launcher');
  //   const settings = InitializationSettings(android: android, iOS: iOS);
  //   await _localNotifications.initialize(
  //     settings,
  //     onSelectNotification: (payload) async {
  //       final message = RemoteMessage.fromMap(jsonDecode(payload!));
  //       handleMessage(message);
  //     },
  //   );
  //   final platform = _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
  //   await platform?.createNotificationChannel(_androidChannel);
  // }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    // FirebaseMessaging.onMessage.listen((message) {
    //   final notification = message.notification;
    //   if (notification == null) return;
    //   _localNotifications.show(notification.hashCode, notification.title, notification.body, NotificationDetails(
    //     android: AndroidNotificationDetails(
    //       _androidChannel.id,
    //       _androidChannel.name,
    //         _androidChannel.description,
    //       icon: '@drawable/ic_launcher'
    //     )
    //   ),
    //     payload: jsonEncode(message.toMap()),
    //   );
    // });
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print('Token: $fcmToken');
    initPushNotifications();
    // initLocalNotifications();
  }
}