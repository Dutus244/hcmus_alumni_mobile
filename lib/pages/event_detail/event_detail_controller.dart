import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcmus_alumni_mobile/model/comment.dart';
import 'package:hcmus_alumni_mobile/model/event.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail/bloc/event_detail_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail/bloc/event_detail_events.dart';

import '../../global.dart';
import 'package:http/http.dart' as http;

import '../../model/comment_response.dart';
import '../../model/event_response.dart';
import '../../model/participant.dart';
import '../../model/participant_response.dart';
import 'bloc/event_detail_states.dart';

class EventDetailController {
  final BuildContext context;

  const EventDetailController({required this.context});

  Future<void> handleGetEvent(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/events/$id';
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var event = Event.fromJson(jsonMap);
        context.read<EventDetailBloc>().add(EventEvent(event));
      } else {}
    } catch (error, stacktrace) {
      // Handle errors
    }
  }

  Future<void> handleGetComment(String id, int page) async {
    if (page == 0) {
      context.read<EventDetailBloc>().add(HasReachedMaxCommentEvent(false));
      context.read<EventDetailBloc>().add(IndexCommentEvent(1));
    } else {
      if (BlocProvider.of<EventDetailBloc>(context)
          .state
          .hasReachedMaxComment) {
        return;
      }
      context.read<EventDetailBloc>().add(IndexCommentEvent(
          BlocProvider.of<EventDetailBloc>(context).state.indexComment + 1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/events/$id/comments';
    var pageSize = 5;
    var token = Global.storageService.getUserAuthToken();
    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };
    try {
      var url = Uri.parse('$apiUrl$endpoint?page=$page&pageSize=$pageSize');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var commentResponse = CommentResponse.fromJson(jsonMap);

        if (commentResponse.comment.isEmpty) {
          if (page == 0) {
            context.read<EventDetailBloc>().add(CommentEvent([]));
          }
          context.read<EventDetailBloc>().add(HasReachedMaxCommentEvent(true));
          return;
        }

        if (page == 0) {
          context
              .read<EventDetailBloc>()
              .add(CommentEvent(commentResponse.comment));
        } else {
          List<Comment> currentList =
              BlocProvider.of<EventDetailBloc>(context).state.comment;
          List<Comment> updatedNewsList = List.of(currentList)
            ..addAll(commentResponse.comment);
          context.read<EventDetailBloc>().add(CommentEvent(updatedNewsList));
        }
      } else {}
    } catch (error, stacktrace) {}
  }

  Future<void> handleGetChildrenComment(String commentId) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/events/comments/${commentId}/children';
    var pageSize = 10;
    var token = Global.storageService.getUserAuthToken();
    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint?page=0&pageSize=$pageSize');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        List<Comment> currentList =
            BlocProvider.of<EventDetailBloc>(context).state.comment;

        for (int i = 0; i < currentList.length; i += 1) {
          if (currentList[i].id == commentId) {
            currentList[i].fetchChildrenComments(jsonMap);
          }
        }
        context.read<EventDetailBloc>().add(CommentEvent(currentList));
      } else {}
    } catch (error, stacktrace) {}
  }

  Future<void> handleGetRelatedEvent() async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/events';
    var pageSize = 3;
    var page = 0;

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint?page=$page&pageSize=$pageSize');

      // Specify UTF-8 encoding for decoding response
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        // Convert the JSON string to a Map
        var jsonMap = json.decode(responseBody);

        // Pass the Map to the fromJson method
        var eventResponse = EventResponse.fromJson(jsonMap);
        context
            .read<EventDetailBloc>()
            .add(RelatedEventEvent(eventResponse.event));
      } else {
        // Handle other status codes if needed
      }
    } catch (error, stacktrace) {
      // Handle errors
    }
  }

  Future<void> handleCheckIsParticipated(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/events/is-participated';
    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint?eventIds=$id');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        context
            .read<EventDetailBloc>()
            .add(IsParticipatedEvent(jsonMap[0]["isParticipated"]));
      } else {}
    } catch (error, stacktrace) {
      // Handle errors
    }
  }

  Future<void> hanldeJoinEvent(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/events/$id/participants';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Specify content type as JSON
    };

    Map<String, dynamic> data = {'note': ''}; // Define your JSON data
    var body = json.encode(data); // Encode the data to JSON

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        context.read<EventDetailBloc>().add(IsParticipatedEvent(true));
      } else {
        // Handle other status codes if needed
      }
    } catch (error, stacktrace) {
      // Handle errors
    }
  }

  Future<void> hanldeExitEvent(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/events/$id/participants';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Specify content type as JSON
    };

    Map<String, dynamic> data = {'note': ''}; // Define your JSON data
    var body = json.encode(data); // Encode the data to JSON

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.delete(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        context.read<EventDetailBloc>().add(IsParticipatedEvent(false));
      } else {
        // Handle other status codes if needed
      }
    } catch (error, stacktrace) {
      // Handle errors
    }
  }

  Future<void> handleGetParticipant(String id, int page) async {
    if (page == 0) {
      context.read<EventDetailBloc>().add(HasReachedMaxParticipantEvent(false));
      context.read<EventDetailBloc>().add(IndexParticipantEvent(1));
    } else {
      if (BlocProvider.of<EventDetailBloc>(context)
          .state
          .hasReachedMaxParticipant) {
        return;
      }
      context.read<EventDetailBloc>().add(IndexParticipantEvent(
          BlocProvider.of<EventDetailBloc>(context).state.indexParticipant +
              1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/events/$id/participants';
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
        var participantResponse = ParticipantResponse.fromJson(jsonMap);
        if (participantResponse.participant.isEmpty) {
          context
              .read<EventDetailBloc>()
              .add(ParticipantEvent(participantResponse.participant));
          context
              .read<EventDetailBloc>()
              .add(HasReachedMaxParticipantEvent(true));
          context
              .read<EventDetailBloc>()
              .add(StatusParticipantEvent(Status.success));
          return;
        }

        if (page == 0) {
          context
              .read<EventDetailBloc>()
              .add(ParticipantEvent(participantResponse.participant));
        } else {
          List<Participant> currentList =
              BlocProvider.of<EventDetailBloc>(context).state.participant;
          List<Participant> updatedNewsList = List.of(currentList)
            ..addAll(participantResponse.participant);
          context
              .read<EventDetailBloc>()
              .add(ParticipantEvent(updatedNewsList));
        }
        if (participantResponse.participant.length < pageSize) {
          context
              .read<EventDetailBloc>()
              .add(HasReachedMaxParticipantEvent(true));
        }
        context
            .read<EventDetailBloc>()
            .add(StatusParticipantEvent(Status.success));
      } else {}
    } catch (error, stacktrace) {}
  }
}
