import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/bloc/news_event_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/bloc/news_event_page_events.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/bloc/news_event_page_states.dart';

import '../../common/values/colors.dart';
import '../../common/widgets/app_bar.dart';
import '../news_event_page/widgets/news_event_page_widget.dart';
import 'news_event_page_controller.dart';

class NewsEventPage extends StatefulWidget {
  final int page; // Biến page cần được khai báo và truyền vào từ bên ngoài
  const NewsEventPage({Key? key, required this.page}) : super(key: key);

  @override
  State<NewsEventPage> createState() => _NewsEventPageState();
}

class _NewsEventPageState extends State<NewsEventPage> {
  late PageController pageController; // Không khởi tạo ở đây
  final _scrollController = ScrollController();
  bool _isFetchingData = false;

  @override
  void initState() {
    super.initState();
    // Khởi tạo pageController trong initState
    pageController = PageController(initialPage: widget.page);
    context.read<NewsEventPageBloc>().add(PageEvent(widget.page));
    _scrollController.addListener(_onScroll);
    NewsEventPageController(context: context).handleLoadNewsData(0);
    NewsEventPageController(context: context).handleLoadEventData(0);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9) && !_isFetchingData) {
      _isFetchingData = true;
      Timer(Duration(seconds: 1), () {
        _isFetchingData = false;
      });

      if (BlocProvider.of<NewsEventPageBloc>(context).state.page == 0) {
        NewsEventPageController(context: context).handleLoadNewsData(
            BlocProvider.of<NewsEventPageBloc>(context).state.indexNews);
      } else {
        NewsEventPageController(context: context).handleLoadEventData(
            BlocProvider.of<NewsEventPageBloc>(context).state.indexEvent);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        final shouldExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Thoát ứng dụng'),
            content: Text('Bạn có muốn thoát ứng dụng?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Huỷ'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Thoát'),
              ),
            ],
          ),
        );
        if (shouldExit) {
          SystemNavigator.pop();
        }
        return shouldExit ?? false;
      },
      child: BlocBuilder<NewsEventPageBloc, NewsEventPageState>(
          builder: (context, state) {
        return Container(
          child: Scaffold(
            appBar: buildAppBar(context, 'Tin tức & Sự kiện'),
            backgroundColor: AppColors.primaryBackground,
            body: BlocProvider.of<NewsEventPageBloc>(context).state.page == 0
                ? listNews(context, _scrollController)
                : listEvent(context, _scrollController),
          ),
        );
      }),
    );
  }
}
