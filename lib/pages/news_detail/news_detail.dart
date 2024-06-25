import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail/bloc/news_detail_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail/bloc/news_detail_events.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail/bloc/news_detail_states.dart';
import 'package:hcmus_alumni_mobile/pages/news_detail/news_detail_controller.dart';
import 'package:popover/popover.dart';
import '../../common/values/colors.dart';
import '../../model/news.dart';
import 'widgets/news_detail_widget.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({super.key});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  late String id;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      id = args["id"];
      NewsDetailController(context: context).handleGetNews(id);
      NewsDetailController(context: context).handleGetComment(id, 0);
      NewsDetailController(context: context).handleGetRelatedNews(id);
    }

    return BlocBuilder<NewsDetailBloc, NewsDetailState>(
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context),
            backgroundColor: AppColors.background,
            body: newsDetail(context),
          );
        });
  }
}
