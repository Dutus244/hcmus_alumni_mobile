import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/values/colors.dart';
import 'bloc/other_profile_page_blocs.dart';
import 'bloc/other_profile_page_states.dart';
import 'bloc/other_profile_page_events.dart';
import 'other_profile_page_controller.dart';
import 'widgets/other_profile_page_widget.dart';

class OtherProfilePage extends StatefulWidget {
  const OtherProfilePage({super.key});

  @override
  State<OtherProfilePage> createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {
  final _scrollController = ScrollController();
  bool _isFetchingData = false;
  String id = "";

  @override
  void initState() {
    super.initState();
    // Khởi tạo pageController trong initState
    _scrollController.addListener(_onScroll);
    context.read<OtherProfilePageBloc>().add(IsLoadingEvent(false));
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9) && !_isFetchingData) {
      _isFetchingData = true;
      Timer(Duration(seconds: 1), () {
        _isFetchingData = false;
      });

      OtherProfilePageController(context: context).handleLoadEventsData(
          BlocProvider.of<OtherProfilePageBloc>(context).state.indexEvent, id);
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      id = args["id"];
      OtherProfilePageController(context: context).handleGetProfile(id);
      OtherProfilePageController(context: context).handleGetJob(id);
      OtherProfilePageController(context: context).handleGetEducation(id);
      OtherProfilePageController(context: context).handleGetAchievement(id);
      OtherProfilePageController(context: context).handleGetFriendCount(id);
      OtherProfilePageController(context: context).handleLoadFriendData(id);
      OtherProfilePageController(context: context).handleLoadEventsData(0, id);
    }

    return BlocBuilder<OtherProfilePageBloc, OtherProfilePageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context),
            backgroundColor: AppColors.background,
            body:  listEvent(context, _scrollController, id),
          );
        });
  }
}
