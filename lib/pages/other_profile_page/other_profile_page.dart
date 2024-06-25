import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/values/colors.dart';
import 'bloc/other_profile_page_blocs.dart';
import 'bloc/other_profile_page_states.dart';
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

  @override
  void initState() {
    super.initState();
    // Khởi tạo pageController trong initState
    _scrollController.addListener(_onScroll);
    OtherProfilePageController(context: context).handleLoadEventsData(0);
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
          BlocProvider.of<OtherProfilePageBloc>(context).state.indexEvent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtherProfilePageBloc, OtherProfilePageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context),
            backgroundColor: AppColors.background,
            body:  listEvent(context, _scrollController),
          );
        });
  }
}
