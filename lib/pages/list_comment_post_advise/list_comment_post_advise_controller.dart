import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/comment.dart';
import '../../model/comment_response.dart';
import 'package:http/http.dart' as http;

import 'bloc/list_comment_post_advise_blocs.dart';
import 'bloc/list_comment_post_advise_events.dart';
import 'bloc/list_comment_post_advise_states.dart';

class ListCommentPostAdviseController {
  final BuildContext context;

  const ListCommentPostAdviseController({required this.context});

  Future<void> handleGetComment(String id, int page) async {
    if (page == 0) {
      context
          .read<ListCommentPostAdviseBloc>()
          .add(HasReachedMaxCommentEvent(false));
      context.read<ListCommentPostAdviseBloc>().add(IndexCommentEvent(1));
    } else {
      if (BlocProvider.of<ListCommentPostAdviseBloc>(context)
          .state
          .hasReachedMaxComment) {
        return;
      }
      context.read<ListCommentPostAdviseBloc>().add(IndexCommentEvent(
          BlocProvider.of<ListCommentPostAdviseBloc>(context)
                  .state
                  .indexComment +
              1));
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/$id/comments';
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
            context.read<ListCommentPostAdviseBloc>().add(CommentsEvent([]));
          }
          context
              .read<ListCommentPostAdviseBloc>()
              .add(HasReachedMaxCommentEvent(true));
          context
              .read<ListCommentPostAdviseBloc>()
              .add(StatusCommentEvent(Status.success));
          return;
        }

        if (page == 0) {
          context
              .read<ListCommentPostAdviseBloc>()
              .add(CommentsEvent(commentResponse.comments));
        } else {
          List<Comment> currentList =
              BlocProvider.of<ListCommentPostAdviseBloc>(context).state.comments;
          List<Comment> updatedNewsList = List.of(currentList)
            ..addAll(commentResponse.comments);
          context
              .read<ListCommentPostAdviseBloc>()
              .add(CommentsEvent(updatedNewsList));
        }
        if (commentResponse.comments.length < pageSize) {
          context
              .read<ListCommentPostAdviseBloc>()
              .add(HasReachedMaxCommentEvent(true));
        }
        context
            .read<ListCommentPostAdviseBloc>()
            .add(StatusCommentEvent(Status.success));
      } else {
        toastInfo(msg: translate('error_get_comment'));
      }
    } catch (error) {
      toastInfo(msg: translate('error_get_comment'));
    }
  }

  Future<void> handleGetChildrenComment(Comment comment) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/comments/${comment.id}/children';
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
            BlocProvider.of<ListCommentPostAdviseBloc>(context).state.comments;

        Comment? parentComment = findParentComment(currentList, comment.id);

        if (parentComment != null) {
          await parentComment.fetchChildrenComments(jsonMap);
        }

        context
            .read<ListCommentPostAdviseBloc>()
            .add(CommentsEvent(currentList));
      } else {
        toastInfo(msg: translate('error_get_comment'));
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

  Future<void> handleLoadWriteComment(String id) async {
    final state = context.read<ListCommentPostAdviseBloc>().state;
    String comment = state.content;

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/$id/comments';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json" // Include bearer token in the headers
    };

    Map data = {'content': comment};
    //encode Map to JSON
    var body = json.encode(data);

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.post(url, headers: headers, body: body);
      print(response.body);
      if (response.statusCode == 201) {
        context
            .read< ListCommentPostAdviseBloc>()
            .add(ContentEvent(''));
        ListCommentPostAdviseController(context: context)
            .handleGetComment(id, 0);
      } else {
        // Handle other status codes if needed
        toastInfo(msg: translate('error_send_comment'));
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: translate('error_send_comment'));
    }
  }

  Future<void> handleLoadWriteChildrenComment(
      String id, String commentId) async {
    final state = context.read<ListCommentPostAdviseBloc>().state;
    String comment = state.content;

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/$id/comments';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    Map data = {'parentId': commentId, 'content': comment};
    var body = json.encode(data);

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        context
            .read< ListCommentPostAdviseBloc>()
            .add(ContentEvent(''));
        ListCommentPostAdviseController(context: context)
            .handleGetComment(id, 0);
      } else {
        // Handle other status codes if needed
        toastInfo(msg: translate('error_send_comment'));
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: translate('error_send_comment'));
    }
  }

  Future<void> handleEditComment(String id, String commentId) async {
    final state = context.read<ListCommentPostAdviseBloc>().state;
    String comment = state.content;

    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/comments/$commentId';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    Map data = {'content': comment};
    var body = json.encode(data);

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        context
            .read< ListCommentPostAdviseBloc>()
            .add(ContentEvent(''));
        ListCommentPostAdviseController(context: context)
            .handleGetComment(id, 0);
      } else {
        // Handle other status codes if needed
        toastInfo(msg: translate('error_edit_comment'));
      }
    } catch (error) {
      // Handle errors
      toastInfo(msg: translate('error_edit_comment'));
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
      var endpoint = '/counsel/comments/$commentId';

      var token = Global.storageService.getUserAuthToken();

      var headers = <String, String>{
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      };

      try {
        var url = Uri.parse('$apiUrl$endpoint');

        var response = await http.delete(url, headers: headers);

        if (response.statusCode == 200) {
          ListCommentPostAdviseController(context: context)
              .handleGetComment(id, 0);
        } else {
          // Handle other status codes if needed
          toastInfo(msg: translate('error_delete_comment'));
        }
      } catch (error) {
        // Handle errors
        toastInfo(msg: translate('error_delete_comment'));
      }
    }
    return shouldDelete ?? false;
  }
}
