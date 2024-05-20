
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/app_bar.dart';
import '../../model/comment.dart';
import '../../model/news.dart';
import 'bloc/news_detail_edit_comment_blocs.dart';
import 'bloc/news_detail_edit_comment_events.dart';
import 'bloc/news_detail_edit_comment_states.dart';
import 'news_detail_edit_comment_controller.dart';
import 'widgets/news_detail_edit_comment_widget.dart';

class NewsDetailEditComment extends StatefulWidget {
  const NewsDetailEditComment({super.key});

  @override
  State<NewsDetailEditComment> createState() => _NewsDetailEditCommentState();
}

class _NewsDetailEditCommentState extends State<NewsDetailEditComment> {
  @override
  void initState() {
    super.initState();
    context
        .read<NewsDetailEditCommentBloc>()
        .add(NewsDetailEditCommentResetEvent());
  }

  late News news;
  late Comment comment;
  late int route;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      route = args["route"];
      news = args["news"];
      comment = args["comment"];
      context
          .read<NewsDetailEditCommentBloc>()
          .add(CommentEvent(comment.content));
    }

    return PopScope(
        canPop: false, // prevent back
        onPopInvoked: (_) async {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/newsDetail",
            (route) => false,
            arguments: {
              "route": route,
              "id": news.id,
            },
          );
        },
        child: BlocBuilder<NewsDetailEditCommentBloc,
            NewsDetailEditCommentState>(builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context, 'Tin tức'),
            backgroundColor: AppColors.primaryBackground,
            body: newsDetailEditComment(context, news, route, comment),
          );
        }));
  }
}
