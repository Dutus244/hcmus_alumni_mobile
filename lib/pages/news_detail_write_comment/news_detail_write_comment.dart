import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail_write_comment/bloc/news_detail_write_comment_states.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail_write_comment/news_detail_write_comment_controller.dart';

import '../../common/values/colors.dart';
import '../../common/values/fonts.dart';
import '../../common/widgets/app_bar.dart';
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
  @override
  void initState() {
    super.initState();
    context
        .read<NewsDetailWriteCommentBloc>()
        .add(NewsDetailWriteCommentResetEvent());
  }

  late News news;
  late int route;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      route = args["route"];
      news = args["news"];
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
        child: BlocBuilder<NewsDetailWriteCommentBloc,
            NewsDetailWriteCommentState>(builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context, 'Tin tức'),
            backgroundColor: AppColors.primaryBackground,
            body: newsDetailWriteComment(context, news, route),
          );
        }));
  }
}
