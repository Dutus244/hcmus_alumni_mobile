import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/bloc/news_event_page_blocs.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/bloc/news_event_page_events.dart';
import 'package:hcmus_alumni_mobile/pages/news_event_page/bloc/news_event_page_states.dart';

import '../../common/values/colors.dart';
import '../news_event_page/widgets/news_event_page_widget.dart';

class NewsEventPage extends StatefulWidget {
  final int page; // Biến page cần được khai báo và truyền vào từ bên ngoài
  const NewsEventPage({Key? key, required this.page}) : super(key: key);

  @override
  State<NewsEventPage> createState() => _NewsEventPageState();
}

class _NewsEventPageState extends State<NewsEventPage> {
  late PageController pageController; // Không khởi tạo ở đây

  @override
  void initState() {
    super.initState();
    // Khởi tạo pageController trong initState
    pageController = PageController(initialPage: widget.page);
    context.read<NewsEventPageBloc>().add(NewsEventPageIndexEvent(widget.page));
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
                appBar: buildAppBar(context),
                backgroundColor: AppColors.primaryBackground,
                body: Container(
                  child: ListView(scrollDirection: Axis.vertical, children: [
                    Container(
                      height: 275.h * 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildButtonChooseNewsOrEvent(context, (value){
                            pageController.animateToPage(
                              value,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.decelerate,
                            );
                          }),
                          Container(
                            height: 10.h,
                          ),
                          Expanded(
                            child: PageView(
                              controller: pageController,
                            onPageChanged: (index) {
                              BlocProvider.of<NewsEventPageBloc>(context).add(NewsEventPageIndexEvent(index));
                            },
                            children: [
                              listNews(),
                              listEvent(),
                            ],
                          ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            );
          }),
    );
  }
}
