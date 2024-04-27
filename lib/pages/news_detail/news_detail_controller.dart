import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hcmus_alumni_mobile/model/comment.dart';
import 'package:hcmus_alumni_mobile/model/comment_response.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail/bloc/news_detail_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail/bloc/news_detail_events.dart';
import 'package:http/http.dart' as http;

import '../../global.dart';
import '../../model/news.dart';
import '../../model/news_response.dart';

class NewsDetailController {
  final BuildContext context;

  const NewsDetailController({required this.context});

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
      } else {}
    } catch (error, stacktrace) {}
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

        if (commentResponse.comment.isEmpty) {
          if (page == 0) {
            context
                .read<NewsDetailBloc>()
                .add(CommentEvent([]));
          }
          context.read<NewsDetailBloc>().add(HasReachedMaxCommentEvent(true));
          return;
        }

        if (page == 0) {
          context
              .read<NewsDetailBloc>()
              .add(CommentEvent(commentResponse.comment));
        } else {
          List<Comment> currentList =
              BlocProvider.of<NewsDetailBloc>(context).state.comment;
          List<Comment> updatedNewsList = List.of(currentList)
            ..addAll(commentResponse.comment);
          context.read<NewsDetailBloc>().add(CommentEvent(updatedNewsList));
        }
      } else {}
    } catch (error, stacktrace) {}
  }

  Future<void> handleGetChildrenComment(String commentId) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/news/comments/${commentId}/children';
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
            BlocProvider.of<NewsDetailBloc>(context).state.comment;

        for (int i = 0; i < currentList.length; i += 1) {
          if (currentList[i].id == commentId) {
            currentList[i].fetchChildrenComments(jsonMap);
          }
        }
        context.read<NewsDetailBloc>().add(CommentEvent(currentList));
      } else {}
    } catch (error, stacktrace) {}
  }

  Future<void> handleGetRelatedNews(String id) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/news/$id/related';
    var limit = '3';
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
      } else {}
    } catch (error, stacktrace) {}
  }
}
