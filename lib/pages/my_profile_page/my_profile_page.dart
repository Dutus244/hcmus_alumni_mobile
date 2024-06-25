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
      } else {
        MyProfilePageController(context: context).handleLoadEventsData(
            BlocProvider.of<MyProfilePageBloc>(context).state.indexEvent);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyProfilePageBloc, MyProfilePageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context),
            backgroundColor: AppColors.background,
            body:  BlocProvider.of<MyProfilePageBloc>(context).state.page == 0
                ? listPosts(context, _scrollController)
                : listEvent(context, _scrollController),
          );
        });
  }
}
