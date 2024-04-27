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
import '../../common/widgets/app_bar.dart';
import '../../model/news.dart';
import 'widgets/news_detail_widget.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({super.key});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  void initState() {
    super.initState();
  }

  late String id;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    var route = 0;
    if (args != null) {
      route = args["route"];
      id = args["id"];
      NewsDetailController(context: context).handleGetNews(id);
      NewsDetailController(context: context).handleGetComment(id, 0);
      NewsDetailController(context: context).handleGetRelatedNews(id);
    }

    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/applicationPage", (route) => false,
            arguments: {"route": route, "secondRoute": 0});
      },
      child: BlocBuilder<NewsDetailBloc, NewsDetailState>(
          builder: (context, state) {
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
                    newsContent(context,
                        BlocProvider.of<NewsDetailBloc>(context).state.news),
                    listComment(
                        context,
                        BlocProvider.of<NewsDetailBloc>(context).state.news,
                        BlocProvider.of<NewsDetailBloc>(context).state.comment),
                    listRelatedNews(
                        context,
                        BlocProvider.of<NewsDetailBloc>(context)
                            .state
                            .relatedNews),
                  ],
                ),
              ),
              // Container nằm dưới cùng của màn hình
              navigation(() {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/applicationPage", (route) => false,
                    arguments: {"route": route, "secondRoute": 0});
              }),
            ],
          ),
        );
      }),
    );
  }
}
