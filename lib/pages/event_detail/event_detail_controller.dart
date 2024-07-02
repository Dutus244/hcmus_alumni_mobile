import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/model/comment.dart';
import 'package:hcmus_alumni_mobile/model/event.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail/bloc/event_detail_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/event_detail/bloc/event_detail_events.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import 'package:http/http.dart' as http;

import '../../model/comment_response.dart';
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
      } else {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        int errorCode = jsonMap['error']['code'];
        if (errorCode == 50200) {
          toastInfo(msg: translate('no_event_found'));
          return;
        }
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: translate('error_get_event'));
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

        if (commentResponse.comments.isEmpty) {
          if (page == 0) {
            context.read<EventDetailBloc>().add(CommentsEvent([]));
          }
          context.read<EventDetailBloc>().add(HasReachedMaxCommentEvent(true));
          return;
        }

        if (page == 0) {
          context
              .read<EventDetailBloc>()
              .add(CommentsEvent(commentResponse.comments));
        } else {
          List<Comment> currentList =
              BlocProvider.of<EventDetailBloc>(context).state.comments;
          List<Comment> updatedNewsList = List.of(currentList)
            ..addAll(commentResponse.comments);
          context.read<EventDetailBloc>().add(CommentsEvent(updatedNewsList));
        }
        if (commentResponse.comments.length < pageSize) {
          context.read<EventDetailBloc>().add(HasReachedMaxCommentEvent(true));
        }
      } else {
        toastInfo(msg: translate('error_get_comment'));
      }
    } catch (error) {
      toastInfo(msg: translate('error_get_comment'));
    }
  }

  Future<void> handleGetChildrenComment(Comment comment) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/events/comments/${comment.id}/children';
    var pageSize = 10;
    var token = Global.storageService.getUserAuthToken();
    var headers = <String, String>{
      'Authorization': 'Bearer $token', // Include bearer token in the headers
    };

    var page = (comment.childrenComments.length / pageSize).toInt();

    try {
      var url = Uri.parse('$apiUrl$endpoint?page=$page&pageSize=$pageSize');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        List<Comment> currentList =
            BlocProvider.of<EventDetailBloc>(context).state.comments;

        Comment? parentComment = findParentComment(currentList, comment.id);

        if (parentComment != null) {
          await parentComment.fetchChildrenComments(jsonMap);
        }

        context.read<EventDetailBloc>().add(CommentsEvent(currentList));
      } else {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        int errorCode = jsonMap['error']['code'];
        if (errorCode == 51300) {
          toastInfo(msg: translate('no_father_comment_found'));
          return;
        }
      }
    } catch (error) {
      toastInfo(msg: translate('error_get_comment'));
    }
  }

  Comment? findParentComment(List<Comment> comments, String commentId) {
    for (var comment in comments) {
      if (comment.id == commentId) {
        return comment;
      }
      if (comment.childrenComments.isNotEmpty) {
        var parent = findParentComment(comment.childrenComments, commentId);
        if (parent != null) {
          return parent;
        }
      }
    }
    return null;
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
    } catch (error) {
      // Handle errors
    }
  }

  Future<void> handleJoinEvent(String id) async {
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
        EventDetailController(context: context).handleGetParticipant(id, 0);
      } else {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        int errorCode = jsonMap['error']['code'];
        if (errorCode == 51000) {
          toastInfo(msg: translate('no_event_found'));
          return;
        }
        if (errorCode == 51001) {
          toastInfo(msg: translate('participated_event'));
          return;
        }
        if (errorCode == 51002) {
          toastInfo(msg: translate('participant_max'));
          return;
        }
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: translate('error_participate_event'));
    }
  }

  Future<void> handleExitEvent(String id) async {
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
        EventDetailController(context: context).handleGetParticipant(id, 0);
      } else {
        // Handle other status codes if needed
        toastInfo(msg: translate('error_cancel_participate_event'));
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: translate('error_cancel_participate_event'));
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
        if (participantResponse.participants.isEmpty) {
          context
              .read<EventDetailBloc>()
              .add(ParticipantsEvent(participantResponse.participants));
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
              .add(ParticipantsEvent(participantResponse.participants));
        } else {
          List<Participant> currentList =
              BlocProvider.of<EventDetailBloc>(context).state.participants;
          List<Participant> updatedNewsList = List.of(currentList)
            ..addAll(participantResponse.participants);
          context
              .read<EventDetailBloc>()
              .add(ParticipantsEvent(updatedNewsList));
        }
        if (participantResponse.participants.length < pageSize) {
          context
              .read<EventDetailBloc>()
              .add(HasReachedMaxParticipantEvent(true));
        }
        context
            .read<EventDetailBloc>()
            .add(StatusParticipantEvent(Status.success));
      } else {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        int errorCode = jsonMap['error']['code'];
        if (errorCode == 50900) {
          toastInfo(msg: translate('no_event_found'));
          return;
        }
      }
    } catch (error) {
      toastInfo(msg: translate('error_get_participant'));
    }
  }

  Future<void> handleDeleteComment(String id, String commentId) async {
    final shouldDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(translate('delete_comment')),
        content: Text(translate('delete_comment_question')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(translate('cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(translate('delete')),
          ),
        ],
      ),
    );
    if (shouldDelete != null && shouldDelete) {
      var apiUrl = dotenv.env['API_URL'];
      var endpoint = '/events/comments/$commentId';

      var token = Global.storageService.getUserAuthToken();

      var headers = <String, String>{
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      };

      try {
        var url = Uri.parse('$apiUrl$endpoint');

        var response = await http.delete(url, headers: headers);

        if (response.statusCode == 200) {
          EventDetailController(context: context).handleGetEvent(id);
          EventDetailController(context: context).handleGetComment(id, 0);
        } else {
          Map<String, dynamic> jsonMap = json.decode(response.body);
          int errorCode = jsonMap['error']['code'];
          if (errorCode == 51600) {
            toastInfo(msg: translate('no_comment_found'));
            return;
          }
        }
      } catch (error) {
        // Handle errors
        toastInfo(msg: translate('error_delete_comment'));
      }
    }
    return shouldDelete ?? false;
  }
}
