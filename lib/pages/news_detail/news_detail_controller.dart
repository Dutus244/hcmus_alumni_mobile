import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hcmus_alumni_mobile/model/comment.dart';
import 'package:hcmus_alumni_mobile/model/comment_response.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail/bloc/news_detail_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail/bloc/news_detail_events.dart';
import 'package:http/http.dart' as http;

import '../../common/widgets/flutter_toast.dart';
import '../../global.dart';
import '../../model/news.dart';
import '../../model/news_response.dart';

class NewsDetailController {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  NewsDetailController({required this.context});

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

  Future<void> handleGetNews(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/news/$id';
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
        var news = News.fromJson(jsonMap);
        context.read<NewsDetailBloc>().add(NewsEvent(news));
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

  Future<void> handleGetComment(String id, int page) async {
    if (page == 0) {
      context.read<NewsDetailBloc>().add(HasReachedMaxCommentEvent(false));
      context.read<NewsDetailBloc>().add(IndexCommentEvent(1));
    } else {
      if (BlocProvider.of<NewsDetailBloc>(context).state.hasReachedMaxComment) {
        return;
      }
      context.read<NewsDetailBloc>().add(IndexCommentEvent(
          BlocProvider.of<NewsDetailBloc>(context).state.indexComment + 1));
      context.read<NewsDetailBloc>().add(IsLoadingEvent(true));
      showLoadingIndicator();
    }
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/news/$id/comments';
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
            context.read<NewsDetailBloc>().add(CommentsEvent([]));
          }
          context.read<NewsDetailBloc>().add(IsLoadingEvent(false));
          hideLoadingIndicator();
          context.read<NewsDetailBloc>().add(HasReachedMaxCommentEvent(true));
          return;
        }

        if (page == 0) {
          context
              .read<NewsDetailBloc>()
              .add(CommentsEvent(commentResponse.comments));
        } else {
          context.read<NewsDetailBloc>().add(IsLoadingEvent(false));
          hideLoadingIndicator();
          List<Comment> currentList =
              BlocProvider.of<NewsDetailBloc>(context).state.comments;
          List<Comment> updatedNewsList = List.of(currentList)
            ..addAll(commentResponse.comments);
          context.read<NewsDetailBloc>().add(CommentsEvent(updatedNewsList));
        }
      } else {
        context.read<NewsDetailBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        toastInfo(msg: translate('error_get_comment'));
      }
    } catch (error) {
      // toastInfo(msg: translate('error_get_comment'));
      hideLoadingIndicator();
    }
  }

  Future<void> handleGetChildrenComment(Comment comment) async {
    context.read<NewsDetailBloc>().add(IsLoadingEvent(true));
    showLoadingIndicator();
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/news/comments/${comment.id}/children';
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
            BlocProvider.of<NewsDetailBloc>(context).state.comments;

        Comment? parentComment = findParentComment(currentList, comment.id);

        if (parentComment != null) {
          await parentComment.fetchChildrenComments(jsonMap);
        }
        context.read<NewsDetailBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        context.read<NewsDetailBloc>().add(CommentsEvent(currentList));
      } else {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        int errorCode = jsonMap['error']['code'];
        context.read<NewsDetailBloc>().add(IsLoadingEvent(false));
        hideLoadingIndicator();
        if (errorCode == 41100) {
          toastInfo(msg: translate('no_father_comment_found'));
          return;
        }
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

  Future<void> handleGetRelatedNews(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/news/$id/related';
    var limit = '5';
    var token = Global.storageService.getUserAuthToken();
    var headers = <String, String>{
      'Authorization': 'Bearer $token',
    };

    try {
      var url = Uri.parse('$apiUrl$endpoint?limit=$limit');
      var response = await http.get(url, headers: headers);
      var responseBody = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        var jsonMap = json.decode(responseBody);
        var newsResponse = NewsResponse.fromJson(jsonMap);
        context.read<NewsDetailBloc>().add(RelatedNewsEvent(newsResponse.news));
      } else {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        int errorCode = jsonMap['error']['code'];
        if (errorCode == 40800) {
          toastInfo(msg: translate('no_news'));
          return;
        }
      }
    } catch (error) {
      // toastInfo(msg: translate('error_get_related_news'));
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
      context.read<NewsDetailBloc>().add(IsLoadingEvent(true));
      showLoadingIndicator();
      var apiUrl = dotenv.env['API_URL'];
      var endpoint = '/news/comments/$commentId';

      var token = Global.storageService.getUserAuthToken();

      var headers = <String, String>{
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      };

      try {
        var url = Uri.parse('$apiUrl$endpoint');

        var response = await http.delete(url, headers: headers);
        if (response.statusCode == 200) {
          await handleGetNews(id);
          await handleGetComment(id, 0);
          context.read<NewsDetailBloc>().add(IsLoadingEvent(false));
          hideLoadingIndicator();
          toastInfo(msg: 'Xoá bình luận thành công');
        } else {
          Map<String, dynamic> jsonMap = json.decode(response.body);
          int errorCode = jsonMap['error']['code'];
          context.read<NewsDetailBloc>().add(IsLoadingEvent(false));
          hideLoadingIndicator();
          if (errorCode == 41400) {
            toastInfo(msg: translate('no_comment_found'));
            return;
          }
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
