import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail_write_comment/bloc/news_detail_write_comment_states.dart';

import '../../common/values/colors.dart';
import '../../model/news.dart';
import '../news_detail_write_comment/bloc/news_detail_write_comment_events.dart';
import 'bloc/news_detail_write_comment_blocs.dart';
import 'widgets/news_detail_write_comment_widget.dart';

class NewsDetailWriteComment extends StatefulWidget {
  const NewsDetailWriteComment({super.key});

  @override
  State<NewsDetailWriteComment> createState() => _NewsDetailWriteCommentState();
}

class _NewsDetailWriteCommentState extends State<NewsDetailWriteComment> {
  late News news;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      news = args["news"];
      context
          .read<NewsDetailWriteCommentBloc>()
          .add(NewsDetailWriteCommentResetEvent());
    }

    return BlocBuilder<NewsDetailWriteCommentBloc,
        NewsDetailWriteCommentState>(builder: (context, state) {
      return Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: AppColors.background,
        body: newsDetailWriteComment(context, news),
      );
    });
  }
}
