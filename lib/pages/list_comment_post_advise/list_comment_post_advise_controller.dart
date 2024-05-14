import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcmus_alumni_mobile/pages/list_react_post_advise/bloc/list_interact_post_advise_events.dart';

import '../../global.dart';
import '../../model/comment.dart';
import '../../model/comment_response.dart';
import '../../model/interact.dart';
import '../../model/interact_response.dart';
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

        if (commentResponse.comment.isEmpty) {
          if (page == 0) {
            context.read<ListCommentPostAdviseBloc>().add(CommentEvent([]));
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
              .add(CommentEvent(commentResponse.comment));
        } else {
          List<Comment> currentList =
              BlocProvider.of<ListCommentPostAdviseBloc>(context).state.comment;
          List<Comment> updatedNewsList = List.of(currentList)
            ..addAll(commentResponse.comment);
          context
              .read<ListCommentPostAdviseBloc>()
              .add(CommentEvent(updatedNewsList));
        }
        if (commentResponse.comment.length < pageSize) {
          context
              .read<ListCommentPostAdviseBloc>()
              .add(HasReachedMaxCommentEvent(true));
        }
        context
            .read<ListCommentPostAdviseBloc>()
            .add(StatusCommentEvent(Status.success));
      } else {}
    } catch (error, stacktrace) {}
  }

  Future<void> handleGetChildrenComment(String commentId) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/comments/$commentId/children';
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
            BlocProvider.of<ListCommentPostAdviseBloc>(context).state.comment;

        // Tìm bình luận cha trong toàn bộ cây bình luận
        Comment? parentComment = findParentComment(currentList, commentId);

        // Nếu tìm thấy bình luận cha, thêm các bình luận con vào nó
        if (parentComment != null) {
          await parentComment.fetchChildrenComments(jsonMap);
        }

        // Thông báo cho Bloc về sự thay đổi
        context
            .read<ListCommentPostAdviseBloc>()
            .add(CommentEvent(currentList));
      } else {
        // Xử lý lỗi hoặc trạng thái không mong muốn
      }
    } catch (error, stacktrace) {
      // Xử lý lỗi
    }
  }

// Hàm đệ qui để tìm bình luận cha trong toàn bộ cây bình luận
  Comment? findParentComment(List<Comment> comments, String commentId) {
    for (var comment in comments) {
      if (comment.id == commentId) {
        return comment; // Bình luận hiện tại là bình luận cha
      }
      // Kiểm tra các bình luận con của bình luận hiện tại
      if (comment.childrenComment.isNotEmpty) {
        var parent = findParentComment(comment.childrenComment, commentId);
        if (parent != null) {
          return parent; // Bình luận cha được tìm thấy trong các bình luận con
        }
      }
    }
    return null; // Không tìm thấy bình luận cha
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
      if (response.statusCode == 201) {
        ListCommentPostAdviseController(context: context)
            .handleGetComment(id, 0);
      } else {
        // Handle other status codes if needed
      }
    } catch (error, stacktrace) {
      // Handle errors
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
        ListCommentPostAdviseController(context: context)
            .handleGetComment(id, 0);
      } else {
        // Handle other status codes if needed
      }
    } catch (error, stacktrace) {
      // Handle errors
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
        ListCommentPostAdviseController(context: context)
            .handleGetComment(id, 0);
      } else {
        // Handle other status codes if needed
      }
    } catch (error, stacktrace) {
      // Handle errors
    }
  }

  Future<void> handleDeleteComment(String id, String commentId) async {
    final shouldDelte = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Xoá bài viết'),
        content: Text('Bạn có muốn Xoá bài viết này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Huỷ'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Xoá'),
          ),
        ],
      ),
    );
    if (shouldDelte) {
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
        }
      } catch (error, stacktrace) {
        // Handle errors
      }
    }
    return shouldDelte ?? false;
  }
}
