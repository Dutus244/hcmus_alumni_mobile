import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/values/colors.dart';
import '../../model/comment.dart';
import '../../model/news.dart';
import 'bloc/news_detail_edit_comment_blocs.dart';
import 'bloc/news_detail_edit_comment_events.dart';
import 'bloc/news_detail_edit_comment_states.dart';
import 'widgets/news_detail_edit_comment_widget.dart';

class NewsDetailEditComment extends StatefulWidget {
  const NewsDetailEditComment({super.key});

  @override
  State<NewsDetailEditComment> createState() => _NewsDetailEditCommentState();
}

class _NewsDetailEditCommentState extends State<NewsDetailEditComment> {
  News? news;
  Comment? comment;

  @override
  void initState() {
    super.initState();
    context.read<NewsDetailEditCommentBloc>().add(IsLoadingEvent(false));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleNavigation();
    });
  }

  void handleNavigation() {
    Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      news = args["news"];
      comment = args["comment"];
      context
          .read<NewsDetailEditCommentBloc>()
          .add(CommentEvent(comment!.content));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsDetailEditCommentBloc,
        NewsDetailEditCommentState>(builder: (context, state) {
      return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: AppColors.background,
        body: newsDetailEditComment(context, news, comment),
      );
    });
  }
}
