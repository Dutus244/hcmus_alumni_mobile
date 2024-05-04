import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/model/comment.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail_write_children_comment/widgets/news_detail_write_children_comment_widget.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/app_bar.dart';
import '../../model/news.dart';
import 'bloc/news_detail_write_children_comment_blocs.dart';
import 'bloc/news_detail_write_children_comment_events.dart';
import 'bloc/news_detail_write_children_comment_states.dart';
import 'news_detail_write_children_comment_controller.dart';

class NewsDetailWriteChildrenComment extends StatefulWidget {
  const NewsDetailWriteChildrenComment({super.key});

  @override
  State<NewsDetailWriteChildrenComment> createState() =>
      _NewsDetailWriteChildrenCommentState();
}

class _NewsDetailWriteChildrenCommentState
    extends State<NewsDetailWriteChildrenComment> {
  @override
  void initState() {
    super.initState();
    context
        .read<NewsDetailWriteChildrenCommentBloc>()
        .add(NewsDetailWriteChildrenCommentResetEvent());
  }

  late News news;
  late Comment comment;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      news = args["news"];
      comment = args["comment"];
    }

    return PopScope(
        canPop: false, // prevent back
        onPopInvoked: (_) async {
          Navigator.of(context).pushNamedAndRemoveUntil(
            "/newsDetail",
            (route) => false,
            arguments: {
              "route": 1,
              "id": news.id,
            },
          );
        },
        child: BlocBuilder<NewsDetailWriteChildrenCommentBloc,
            NewsDetailWriteChildrenCommentState>(builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context, 'Tin tức'),
            backgroundColor: AppColors.primaryBackground,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      header(news, comment),
                      buildTextField('Bình luận của bạn', 'comment', '',
                          (value) {
                        context
                            .read<NewsDetailWriteChildrenCommentBloc>()
                            .add(CommentEvent(value));
                      }),
                    ],
                  ),
                ),
                navigation(
                    () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        "/newsDetail",
                        (route) => false,
                        arguments: {
                          "route": 1,
                          "id": news.id,
                        },
                      );
                    },
                    BlocProvider.of<NewsDetailWriteChildrenCommentBloc>(context)
                        .state
                        .comment,
                    () {
                      NewsDetailWriteChildrenCommentController(context: context)
                          .handleLoadWriteComment(news.id, comment.id);
                    }),
              ],
            ),
          );
        }));
  }
}
