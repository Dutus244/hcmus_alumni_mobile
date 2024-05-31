import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    } catch (error) {}
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

        if (commentResponse.comments.isEmpty) {
          if (page == 0) {
            context.read<NewsDetailBloc>().add(CommentsEvent([]));
          }
          context.read<NewsDetailBloc>().add(HasReachedMaxCommentEvent(true));
          return;
        }

        if (page == 0) {
          context
              .read<NewsDetailBloc>()
              .add(CommentsEvent(commentResponse.comments));
        } else {
          List<Comment> currentList =
              BlocProvider.of<NewsDetailBloc>(context).state.comments;
          List<Comment> updatedNewsList = List.of(currentList)
            ..addAll(commentResponse.comments);
          context.read<NewsDetailBloc>().add(CommentsEvent(updatedNewsList));
        }
      } else {}
    } catch (error) {}
  }

  Future<void> handleGetChildrenComment(String commentId) async {
    var apiUrl = dotenv.env['API_URL'];
    var endpoint = '/news/comments/$commentId/children';
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
            BlocProvider.of<NewsDetailBloc>(context).state.comments;

        // Tìm bình luận cha trong toàn bộ cây bình luận
        Comment? parentComment = findParentComment(currentList, commentId);

        // Nếu tìm thấy bình luận cha, thêm các bình luận con vào nó
        if (parentComment != null) {
          await parentComment.fetchChildrenComments(jsonMap);
        }

        // Thông báo cho Bloc về sự thay đổi
        context.read<NewsDetailBloc>().add(CommentsEvent(currentList));
      } else {
        // Xử lý lỗi hoặc trạng thái không mong muốn
      }
    } catch (error) {
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
      if (comment.childrenComments.isNotEmpty) {
        var parent = findParentComment(comment.childrenComments, commentId);
        if (parent != null) {
          return parent; // Bình luận cha được tìm thấy trong các bình luận con
        }
      }
    }
    return null; // Không tìm thấy bình luận cha
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
    } catch (error) {}
  }

  Future<void> handleDeleteComment(String id, String commentId) async {
    final shouldDelte = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Xoá bình luận'),
        content: Text('Bạn có muốn xoá bình luận này?'),
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
    if (shouldDelte != null && shouldDelte) {
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
          NewsDetailController(context: context).handleGetNews(id);
          NewsDetailController(context: context).handleGetComment(id, 0);
        } else {
          // Handle other status codes if needed
        }
      } catch (error) {
        // Handle errors
      }
    }
    return shouldDelte ?? false;
  }
}
