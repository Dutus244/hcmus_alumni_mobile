import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hcmus_alumni_mobile/pages/hof_page/hof_page_controller.dart';
import 'package:hcmus_alumni_mobile/pages/hof_page/widgets/hof_page_widget.dart';

import '../../common/values/colors.dart';
import 'bloc/hof_page_blocs.dart';
import 'bloc/hof_page_states.dart';

class HofPage extends StatefulWidget {
  const HofPage({super.key});

  @override
  State<HofPage> createState() => _HofPageState();
}

class _HofPageState extends State<HofPage> {
  late PageController pageController; // Không khởi tạo ở đây
  final _scrollController = ScrollController();
  bool _isFetchingData = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    HofPageController(context: context).handleLoadHofData(0);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9) && !_isFetchingData) {
      _isFetchingData = true;
      Timer(Duration(seconds: 1), () {
        _isFetchingData = false;
      });

      HofPageController(context: context).handleLoadHofData(
          BlocProvider.of<HofPageBloc>(context).state.indexHof);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/applicationPage", (route) => false,
            arguments: {"route": 0, "secondRoute": 1});
      },
      child: BlocBuilder<HofPageBloc, HofPageState>(builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar(context),
          backgroundColor: AppColors.primaryBackground,
          body: listHof(context, _scrollController),
        );
      }),
    );
  }
}
