import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/values/colors.dart';
import 'bloc/my_profile_page_blocs.dart';
import 'bloc/my_profile_page_states.dart';
import 'my_profile_page_controller.dart';
import 'widgets/my_profile_page_widget.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final _scrollController = ScrollController();
  bool _isFetchingData = false;

  @override
  void initState() {
    super.initState();
    // Khởi tạo pageController trong initState
    _scrollController.addListener(_onScroll);
    MyProfilePageController(context: context).handleLoadEventsData(0);
    MyProfilePageController(context: context).handleLoadPostData(0);
    MyProfilePageController(context: context).handleLoadCommentPostAdviseData(0);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9) && !_isFetchingData) {
      _isFetchingData = true;
      Timer(Duration(seconds: 1), () {
        _isFetchingData = false;
      });

      if (BlocProvider.of<MyProfilePageBloc>(context).state.page == 0) {
        MyProfilePageController(context: context).handleLoadPostData(
            BlocProvider.of<MyProfilePageBloc>(context).state.indexPost);
      } else if (BlocProvider.of<MyProfilePageBloc>(context).state.page == 1) {
        MyProfilePageController(context: context).handleLoadEventsData(
            BlocProvider.of<MyProfilePageBloc>(context).state.indexEvent);
      } else if (BlocProvider.of<MyProfilePageBloc>(context).state.page == 2) {
        MyProfilePageController(context: context).handleLoadCommentPostAdviseData(
            BlocProvider.of<MyProfilePageBloc>(context).state.indexCommentAdvise);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyProfilePageBloc, MyProfilePageState>(
      builder: (context, state) {
        Widget body;
        switch (state.page) {
          case 0:
            body = listPosts(context, _scrollController);
            break;
          case 1:
            body = listEvent(context, _scrollController);
            break;
          case 2:
            body = listCommentAdvise(context, _scrollController);
            break;
          default:
            body = Center(child: Text('Page not found'));
        }

        return Scaffold(
          appBar: buildAppBar(context),
          backgroundColor: AppColors.background,
          body: body,
        );
      },
    );
  }
}
