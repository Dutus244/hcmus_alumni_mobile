import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/common/values/assets.dart';
import 'package:hcmus_alumni_mobile/common/values/constants.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../common/function/handle_save_permission.dart';
import '../../common/services/firebase_service.dart';
import '../../common/services/socket_service.dart';
import '../../common/values/colors.dart';
import '../../global.dart';
import 'package:http/http.dart' as http;

import '../../model/user.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  NotificationServices notificationServices = NotificationServices();
  String entityTable = "";
  String notificationType = "";
  String entityId = "";
  String parentId = "";
  String name = "";

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermisions();
    notificationServices.foregroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isRefreshToken();
    notificationServices.getDeviceToken().then((value) {
      print(value);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleNavigation();
    });
  }

  Future<void> handleNavigation() async {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      entityTable = args["entityTable"] ?? "";
      notificationType = args["notificationType"] ?? "";
      entityId = args["entityId"] ?? "";
      parentId = args["parentId"] ?? "";
      name = args["name"] ?? "";
      switch (entityTable) {
        case "request_friend":
          switch (notificationType) {
            case "CREATE":
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/applicationPage", (route) => false,
                  arguments: {"route": 4});
              break;
            case "DELETE":
              Navigator.of(context).pushNamed("/otherProfilePage", arguments: {
                "id": entityId,
              });
              break;
          }
          break;
        case "friend":
          Navigator.of(context).pushNamed("/otherProfilePage", arguments: {
            "id": entityId,
          });
          break;
        case "comment_event":
          Navigator.of(context).pushNamed(
            "/eventDetail",
            arguments: {"id": parentId},
          );
          break;
        case "news_event":
          Navigator.of(context).pushNamed(
            "/newsDetail",
            arguments: {"id": parentId},
          );
          break;
        case "group":
          Navigator.of(context).pushNamed(
            "/groupDetail",
            arguments: {"id": entityId},
          );
          break;
        case "request_join_group":
          switch (notificationType) {
            case "CREATE":
              Navigator.of(context).pushNamed(
                "/groupMemberApprove",
                arguments: {"groupId": entityId},
              );
              break;
            case "UPDATE":
              Navigator.of(context).pushNamed(
                "/groupDetail",
                arguments: {"id": entityId},
              );
              break;
          }
          break;
        case "interact_post_group":
          Navigator.of(context).pushNamed(
            "/postGroupDetail",
            arguments: {"id": entityId},
          );
          break;
        case "comment_post_group":
          List<String> temp = parentId.toString().split(',');
          Navigator.of(context).pushNamed(
            "/postGroupDetail",
            arguments: {"id": temp[0]},
          );
          break;
        case "interact_post_advise":
          Navigator.of(context).pushNamed(
            "/postAdviseDetail",
            arguments: {"id": entityId},
          );
          break;
        case "comment_post_advise":
          Navigator.of(context).pushNamed(
            "/postAdviseDetail",
            arguments: {"id": parentId},
          );
          break;
        case "message":
          Navigator.of(context).pushNamed(
            "/chatDetail",
            arguments: {"inboxId": int.parse(parentId), "name": name},
          );
          break;
      }
    } else {
      if (Global.storageService.getUserRememberLogin()) {
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

            Global.storageService
                .setString(AppConstants.USER_AUTH_TOKEN, jwtToken);
            Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);
            Global.storageService
                .setString(AppConstants.USER_ID, decodedToken["sub"]);
            List<String> permissions =
                List<String>.from(jsonMap['permissions']);
            handleSavePermission(permissions);
            socketService.connect(Global.storageService.getUserId());

            url = Uri.parse(
                '${dotenv.env['API_URL']}/user/${Global.storageService.getUserId()}/profile');
            try {
              var response = await http.get(url, headers: headers);
              var responseBody = utf8.decode(response.bodyBytes);
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
            Navigator.of(context).pushNamedAndRemoveUntil(
                "/applicationPage", (route) => false,
                arguments: {"route": 0});
          } else {
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/signIn", (route) => false);
          }
        } catch (error) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/signIn", (route) => false);
        }
      } else {
        Timer(Duration(seconds: 2), () {
          if (Global.storageService.getDeviceFirstOpen()) {
            Global.storageService
                .setBool(AppConstants.DEVICE_OPEN_FIRST_TIME, false);
            Locale currentLocale = Localizations.localeOf(context);
            Global.storageService.setString(
                AppConstants.DEVICE_LANGUAGE, currentLocale.toString());
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/welcome", (route) => false);
          } else {
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/signIn", (route) => false);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Scaffold(
        body: Row(
          children: [
            Center(
              child: Container(
                width: 345.w,
                height: 345.w,
                child: Image.asset(
                  AppAssets.logoImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
