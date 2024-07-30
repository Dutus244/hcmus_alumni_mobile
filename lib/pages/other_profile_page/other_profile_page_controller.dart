import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/achievement_response.dart';
import '../../model/education_response.dart';
import '../../model/event.dart';
import '../../model/event_response.dart';
import '../../model/friend_response.dart';
import '../../model/job_response.dart';
import '../../model/user.dart';
import 'bloc/other_profile_page_blocs.dart';
import 'bloc/other_profile_page_events.dart';
import 'bloc/other_profile_page_states.dart';
import 'package:http/http.dart' as http;

class OtherProfilePageController {
  final BuildContext context;

  const OtherProfilePageController({required this.context});

  Future<void> handleLoadEventsData(int page, String userId) async {
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
    var endpoint = '/events/participated';
    var pageSize = 5;
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint?page=$page&pageSize=$pageSize&requestedUserId=$userId');
      print('$apiUrl$endpoint?page=$page&pageSize=$pageSize&requestedUserId=$userId');
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

  Future<void> handleGetProfile(String id) async {
    var token = Global.storageService.getUserAuthToken();
    var url = Uri.parse(
        '${dotenv.env['API_URL']}/user/$id/profile');
    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var user = User.fromJson(jsonMap["user"]);
        context.read<OtherProfilePageBloc>().add(UserEvent(user));
        context.read<OtherProfilePageBloc>().add(IsFriendStatusEvent(jsonMap["isFriendStatus"]));
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleGetFriendCount(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/$id/friends/count';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };

    try {
      var url = Uri.parse(
          '$apiUrl$endpoint');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      context.read<OtherProfilePageBloc>().add(FriendCountEvent(int.parse(responseBody)));
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleLoadFriendData(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/$id/friends';
    var pageSize = 6;

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };

    try {
      var url = Uri.parse(
          '$apiUrl$endpoint?page=0&pageSize=$pageSize');

      // Specify UTF-8 encoding for decoding response
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        // Convert the JSON string to a Map
        var jsonMap = json.decode(responseBody);
        // Pass the Map to the fromJson method
        var friendResponse = FriendResponse.fromJson(jsonMap);
        context
            .read<OtherProfilePageBloc>()
            .add(FriendsEvent(friendResponse.friends));
      } else {
        // Handle other status codes if needed
        toastInfo(msg: translate('error_get_friend'));
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: translate('error_get_friend'));
    }
  }

  Future<void> handleGetJob(String id) async {
    var token = Global.storageService.getUserAuthToken();
    var url = Uri.parse(
        '${dotenv.env['API_URL']}/user/$id/profile/job');
    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var jobResponse = JobResponse.fromJson(jsonMap);
        context.read<OtherProfilePageBloc>().add(JobsEvent(jobResponse.jobs));
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleGetEducation(String id) async {
    var token = Global.storageService.getUserAuthToken();
    var url = Uri.parse(
        '${dotenv.env['API_URL']}/user/$id/profile/education');
    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var educationResponse = EducationResponse.fromJson(jsonMap);
        context
            .read<OtherProfilePageBloc>()
            .add(EducationsEvent(educationResponse.educations));
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleGetAchievement(String id) async {
    var token = Global.storageService.getUserAuthToken();
    var url = Uri.parse(
        '${dotenv.env['API_URL']}/user/$id/profile/achievement');
    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var achievementResponse = AchievementResponse.fromJson(jsonMap);
        context
            .read<OtherProfilePageBloc>()
            .add(AchievementsEvent(achievementResponse.achievements));
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleInbox(User user) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/messages/inbox';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    var temp = {'id': user.id}; // Example user object
    Map data = {
      'members': [
        {
          'userId': temp['id'],
        }
      ]
    };

    var body = json.encode(data);

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        int inboxId = jsonMap['inboxId'];

        Navigator.pushNamed(context, "/chatDetail", arguments: {
          "inboxId": inboxId,
          "name": user.fullName,
        });
      } else {
        // Handle other status codes if needed
        toastInfo(msg: translate('error_create_inbox'));
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: translate('error_create_inbox'));
      print(error);
    }
  }

  Future<void> handleSendRequest(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/friends/requests';
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    var body = json.encode({
      'friendId': id,
    });

    try {
      // Send the request
      var response = await http.post(
        Uri.parse('$apiUrl$endpoint'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 201) {
        handleGetProfile(id);
      } else {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        int errorCode = jsonMap['error']['code'];
        if (errorCode == 23203) {
          handleGetProfile(id);
          return;
        }
        toastInfo(msg: translate('error_send_request'));
      }
    } catch (e) {
      // Exception occurred
      toastInfo(msg: translate('error_send_request'));
      print(e);
      return;
    }
  }

  Future<bool> handleDeleteFriend(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/user/friends/$id';
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    try {
      // Send the request
      var response = await http.delete(
        Uri.parse('$apiUrl$endpoint'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        handleGetProfile(id);
        return true;
      } else {
        toastInfo(msg: translate('error_delete_friend'));
        return false;
      }
    } catch (e) {
      // Exception occurred
      toastInfo(msg: translate('error_delete_friend'));
      print(e);
      return false;
    }
  }
}
