import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/pages/post_advise_detail/bloc/post_advise_detail_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/post_advise_detail/bloc/post_advise_detail_events.dart';
import 'package:hcmus_alumni_mobile/pages/post_advise_detail/bloc/post_advise_detail_states.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/comment.dart';
import '../../model/comment_response.dart';
import '../../model/post.dart';

class PostAdviseDetailController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  PostAdviseDetailController({required this.context});

  void showLoadingIndicator() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).size.height * 0.5 - 30,
        left: MediaQuery.of(context).size.width * 0.5 - 30,
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void hideLoadingIndicator() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  Future<void> handleLoadPostData(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/$id';
    var token = Global.storageService.getUserAuthToken();
    var headers = <String, String>{
      'Authorization': 'Bearer $token',
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var post = Post.fromJson(jsonMap);
        context.read<PostAdviseDetailBloc>().add(PostEvent(post));
      } else {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        int errorCode = jsonMap['error']['code'];
        if (errorCode == 40300) {
          toastInfo(msg: translate('no_news'));
          return;
        }
      }
    } catch (error) {
      // toastInfo(msg: translate('error_get_news'));
    }
  }

  Future<void> handleLikePost(String id) async {
    context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
    var post = BlocProvider.of<PostAdviseDetailBloc>(context).state.post;
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/$id/react';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Specify content type as JSON
    };

    Map<String, dynamic> data = {'reactId': 1}; // Define your JSON data
    var body = json.encode(data); // Encode the data to JSON
    var url = Uri.parse('$apiUrl$endpoint');

    if (post!.isReacted) {
      var response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        await handleLoadPostData(id);
      } else {
        // Handle other status codes if needed
        toastInfo(msg: translate('error_unlike_post'));
      }
      context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
      hideLoadingIndicator();
    } else {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        await handleLoadPostData(id);
      } else {
        // Handle other status codes if needed
        toastInfo(msg: translate('error_like_post'));
      }
      context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
      hideLoadingIndicator();
    }
  }

  Future<bool> handleDeletePost(String id) async {
    final shouldDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(translate('delete_post')),
        content: Text(translate('delete_post_question')),
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
      context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(true));
      showLoadingIndicator();
      var apiUrl = dotenv.env['API_URL'];
      var endpoint = '/counsel/$id';

      var token = Global.storageService.getUserAuthToken();

      var headers = <String, String>{
        'Authorization': 'Bearer $token',
      };

      try {
        var url = Uri.parse('$apiUrl$endpoint');

        var response = await http.delete(url, headers: headers);
        if (response.statusCode == 200) {
          context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
          hideLoadingIndicator();
          toastInfo(msg: 'Xoá bài viết thành công');
          Navigator.pop(context);
          return true;
        } else {
          context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
          hideLoadingIndicator();
          // Handle other status codes if needed
          toastInfo(msg: translate('error_delete_post'));
          return false;
        }
      } catch (error) {
        // Handle errors
        // toastInfo(msg: translate('error_delete_post'));
        hideLoadingIndicator();
        return false;
      }
    }
    return shouldDelete ?? false;
  }

  Future<void> handleVote(String id, int newVoteId) async {
    context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/$id/votes/$newVoteId';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Specify content type as JSON
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.post(url, headers: headers);
      if (response.statusCode == 201) {
        await handleLoadPostData(id);
        context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
      } else {
        // Handle other status codes if needed
        context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_choose_option'));
        return;
      }
    } catch (error) {
      // Handle errors
      // toastInfo(msg: translate('error_choose_option'));
      hideLoadingIndicator();
      return;
    }
  }

  Future<void> handleDeleteVote(String id, int voteId) async {
    context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/$id/votes/$voteId';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Specify content type as JSON
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        await handleLoadPostData(id);
        context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
      } else {
        // Handle other status codes if needed
        context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_not_choose_option'));
        return;
      }
    } catch (error) {
      // Handle errors
      // toastInfo(msg: translate('error_not_choose_option'));
      hideLoadingIndicator();
      return;
    }
  }

  Future<void> handleUpdateVote(String id, int oldVoteId, int newVoteId) async {
    context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/$id/votes/$oldVoteId';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Specify content type as JSON
    };

    Map<String, dynamic> data = {
      'updatedVoteId': newVoteId
    }; // Define your JSON data
    var body = json.encode(data); // Encode the data to JSON
    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        await handleLoadPostData(id);
        context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
      } else {
        // Handle other status codes if needed
        context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_change_option'));
        return;
      }
    } catch (error) {
      // Handle errors
      // toastInfo(msg: translate('error_change_option'));
      hideLoadingIndicator();
      return;
    }
  }

  Future<void> handleAddVote(String id, String vote) async {
    context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/counsel/$id/votes';

    var token = Global.storageService.getUserAuthToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final map = <String, dynamic>{};
    map['name'] = vote;

    try {
      var url = Uri.parse('$apiUrl$endpoint');

      var response =
      await http.post(url, headers: headers, body: json.encode(map));
      if (response.statusCode == 201) {
        await handleLoadPostData(id);
        context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: 'Thêm lựa chọn thành công');
      } else {
        // Handle other status codes if needed
        toastInfo(msg: translate('error_add_option'));
        context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        return;
      }
    } catch (error) {
      // Handle errors
      // toastInfo(msg: translate('error_add_option'));
      hideLoadingIndicator();
      return;
    }
  }

  Future<void> handleGetComment(String id, int page) async {
    if (page == 0) {
      context
          .read<PostAdviseDetailBloc>()
          .add(HasReachedMaxCommentEvent(false));
      context.read<PostAdviseDetailBloc>().add(IndexCommentEvent(1));
    } else {
      if (BlocProvider.of<PostAdviseDetailBloc>(context)
          .state
          .hasReachedMaxComment) {
        return;
      }
      context.read<PostAdviseDetailBloc>().add(IndexCommentEvent(
          BlocProvider.of<PostAdviseDetailBloc>(context)
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
            context.read<PostAdviseDetailBloc>().add(CommentsEvent([]));
          }
          context
              .read<PostAdviseDetailBloc>()
              .add(HasReachedMaxCommentEvent(true));
          context
              .read<PostAdviseDetailBloc>()
              .add(StatusCommentEvent(Status.success));
          return;
        }

        if (page == 0) {
          context
              .read<PostAdviseDetailBloc>()
              .add(CommentsEvent(commentResponse.comments));
        } else {
          List<Comment> currentList =
              BlocProvider.of<PostAdviseDetailBloc>(context).state.comments;
          List<Comment> updatedNewsList = List.of(currentList)
            ..addAll(commentResponse.comments);
          context
              .read<PostAdviseDetailBloc>()
              .add(CommentsEvent(updatedNewsList));
        }
        if (commentResponse.comments.length < pageSize) {
          context
              .read<PostAdviseDetailBloc>()
              .add(HasReachedMaxCommentEvent(true));
        }
        context
            .read<PostAdviseDetailBloc>()
            .add(StatusCommentEvent(Status.success));
      } else {
        toastInfo(msg: translate('error_get_comment'));
      }
    } catch (error) {
      // toastInfo(msg: translate('error_get_comment'));
    }
  }

  Future<void> handleGetChildrenComment(Comment comment) async {
    context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
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
            BlocProvider.of<PostAdviseDetailBloc>(context).state.comments;

        Comment? parentComment = findParentComment(currentList, comment.id);

        if (parentComment != null) {
          await parentComment.fetchChildrenComments(jsonMap);
        }
        context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        context
            .read<PostAdviseDetailBloc>()
            .add(CommentsEvent(currentList));
      } else {
        context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_get_comment'));
      }
    } catch (error) {
      // toastInfo(msg: translate('error_get_comment'));
      hideLoadingIndicator();
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
    context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
    final state = context.read<PostAdviseDetailBloc>().state;
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
        context
            .read<PostAdviseDetailBloc>()
            .add(ContentEvent(''));
        await handleGetComment(id, 0);
        context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: 'Bình luận thành công');
      } else {
        // Handle other status codes if needed
        context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_send_comment'));
      }
    } catch (error) {
      // Handle errors
      // toastInfo(msg: translate('error_send_comment'));
      hideLoadingIndicator();
    }
  }

  Future<void> handleLoadWriteChildrenComment(
      String id, String commentId) async {
    context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
    final state = context.read<PostAdviseDetailBloc>().state;
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
            .read<PostAdviseDetailBloc>()
            .add(ContentEvent(''));
        await handleGetComment(id, 0);
        context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: 'Bình luận thành công');
      } else {
        // Handle other status codes if needed
        context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_send_comment'));
      }
    } catch (error) {
      // Handle errors
      // toastInfo(msg: translate('error_send_comment'));
      hideLoadingIndicator();
    }
  }

  Future<void> handleEditComment(String id, String commentId) async {
    context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
    final state = context.read<PostAdviseDetailBloc>().state;
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
            .read<PostAdviseDetailBloc>()
            .add(ContentEvent(''));
        await handleGetComment(id, 0);
        context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: 'Sửa bình luận thành công');
      } else {
        // Handle other status codes if needed
        context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_edit_comment'));
      }
    } catch (error) {
      // Handle errors
      // toastInfo(msg: translate('error_edit_comment'));
      hideLoadingIndicator();
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
      context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(true));
      showLoadingIndicator();
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
          await handleGetComment(id, 0);
          context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
          hideLoadingIndicator();
          toastInfo(msg: 'Xoá bình luận thành công');
        } else {
          // Handle other status codes if needed
          context.read<PostAdviseDetailBloc>().add(IsLoadingEvent(false));
          hideLoadingIndicator();
          toastInfo(msg: translate('error_delete_comment'));
        }
      } catch (error) {
        // Handle errors
        // toastInfo(msg: translate('error_delete_comment'));
        hideLoadingIndicator();
      }
    }
    return shouldDelete ?? false;
  }
}